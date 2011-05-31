From: Christopher Li <sparse@chrisli.org>
Subject: Re: vector_size attribute?
Date: Tue, 31 May 2011 04:22:37 -0700
Message-ID: <BANLkTi=dxxdSBtBYWD_1Cm8NKnL2chY4rA@mail.gmail.com>
References: <20110529085726.c0234647.rdunlap@xenotime.net>
	<4DE273B0.7000800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41566 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab1EaLWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 May 2011 07:22:39 -0400
Received: by wwa36 with SMTP id 36so4754295wwa.1
        for <linux-sparse@vger.kernel.org>; Tue, 31 May 2011 04:22:38 -0700 (PDT)
In-Reply-To: <4DE273B0.7000800@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Sun, May 29, 2011 at 9:26 AM, Avi Kivity <avi@redhat.com> wrote:
> On 05/29/2011 06:57 PM, Randy Dunlap wrote:
>> typedef u32 __attribute__((vector_size(16))) sse128_t;
>
> I guess sparse should be taught about it. =A0It's needed so that gcc =
asm
> constraints are aware of what memory is touched when running an sse
> instruction.
>
> (probably ignoring it for now should be sufficient)

I just submit a change to ignore that attribute. Works fine with
the trivial test case.

Chris

commit d8b20ec2324b09b164b298fbab6b4265b6886929
Author: Christopher Li <sparse@chrisli.org>
Date:   Tue May 31 04:05:37 2011 -0700

    Ignore attribute vector_size

    Report by Randy Dunlap, attribute vector_size is causing
    error. Ignore it for now.

    Signed-off-by: Christopher Li <sparse@chrisli.org>

diff --git a/parse.c b/parse.c
index 9e79ef0..57f369b 100644
--- a/parse.c
+++ b/parse.c
@@ -563,6 +563,7 @@ const char *ignored_attributes[] =3D {
        "__unused__",
        "used",
        "__used__",
+       "vector_size",
        "visibility",
        "__visibility__",
        "warn_unused_result",
diff --git a/validation/attr_vector_size.c b/validation/attr_vector_siz=
e.c
new file mode 100644
index 0000000..6982922
--- /dev/null
+++ b/validation/attr_vector_size.c
@@ -0,0 +1,7 @@
+typedef unsigned int u32;
+typedef u32 __attribute__((vector_size(16))) sse128_t;
+
+/*
+ * check-name: attribute vector_size
+ */
+
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
