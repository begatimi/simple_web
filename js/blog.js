var requesti = new XMLHttpRequest();
var data = [];

requesti.onreadystatechange = Statusi;
requesti.open("GET", "Data/blog.json", true);
requesti.send();

function Statusi() {
    if (requesti.readyState == 4) {
        const objekti = JSON.parse(this.responseText);
        data.push(objekti);

        var blogsList = document.getElementById("blogsId");
        var output = '';

        data[0].forEach(item => {

            output += `
                    <td>
						<article>
							<img src="${item.Image}" height="116px" width="320px" alt="applee" />
							<h3 style="color:blue;border-bottom:5px blue solid;border-radius:2px;">${item.Title}</h3>
							<p>${item.Description}</p>
                            <p>${item.Author}</p>
						</article>
					</td>
            `;
        });

        blogsList.innerHTML = output;
    }
}