function DergoEmail() {

    var name = $("name").val();
    var email = $("email").val();
    var message = $("message").val();
    var dataPrivacy = $("dataPrivacy").val();

    try {

        if (!(IsNullOrEmpty(name) && IsNullOrEmpty(email) && IsNullOrEmpty(message) && IsNullOrEmpty(dataPrivacy))) {

            var rechapchaToken = document.getElementById("RechapchaToken").value;

            var mailSubject = AppSettings.Subjekti.replace("@Subject@", name);

            var body = AppSettings.MailBody
                .replace("@Name@", name)
                .replace("@Email@", email)
                .replace("@MailMessage@", message)
                .replace("@DataPrivacy@", dataPrivacy);

            var data = {

                "from": email,
                "displayName": name,
                "to": AppSettings.ServiceEmail,
                "subject": mailSubject,
                "body": body,
                "origin": location.origin
            };
        }
    } catch (e) {
        console.log(e.message);
        return false;
    }
}

function IsNullOrEmpty(value) {
    if (value == null || value == "" || value == undefined)
        return true;
    else
        return false;
}