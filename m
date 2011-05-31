From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: vector_size attribute?
Date: Tue, 31 May 2011 11:31:28 -0700
Message-ID: <20110531113128.12fbabee.rdunlap@xenotime.net>
References: <20110529085726.c0234647.rdunlap@xenotime.net>
	<4DE273B0.7000800@redhat.com>
	<BANLkTi=dxxdSBtBYWD_1Cm8NKnL2chY4rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:53621 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757511Ab1EaSbb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 May 2011 14:31:31 -0400
In-Reply-To: <BANLkTi=dxxdSBtBYWD_1Cm8NKnL2chY4rA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Avi Kivity <avi@redhat.com>, linux-sparse@vger.kernel.org

On Tue, 31 May 2011 04:22:37 -0700 Christopher Li wrote:

> On Sun, May 29, 2011 at 9:26 AM, Avi Kivity <avi@redhat.com> wrote:
> > On 05/29/2011 06:57 PM, Randy Dunlap wrote:
> >> typedef u32 __attribute__((vector_size(16))) sse128_t;
> >
> > I guess sparse should be taught about it. =A0It's needed so that gc=
c asm
> > constraints are aware of what memory is touched when running an sse
> > instruction.
> >
> > (probably ignoring it for now should be sufficient)
>=20
> I just submit a change to ignore that attribute. Works fine with
> the trivial test case.

Works on kernel source tree also (of course).  Thanks.


> Chris
>=20
> commit d8b20ec2324b09b164b298fbab6b4265b6886929
> Author: Christopher Li <sparse@chrisli.org>
> Date:   Tue May 31 04:05:37 2011 -0700
>=20
>     Ignore attribute vector_size
>=20
>     Report by Randy Dunlap, attribute vector_size is causing
>     error. Ignore it for now.
>=20
>     Signed-off-by: Christopher Li <sparse@chrisli.org>
>=20
> diff --git a/parse.c b/parse.c
> index 9e79ef0..57f369b 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -563,6 +563,7 @@ const char *ignored_attributes[] =3D {
>         "__unused__",
>         "used",
>         "__used__",
> +       "vector_size",
>         "visibility",
>         "__visibility__",
>         "warn_unused_result",
> diff --git a/validation/attr_vector_size.c b/validation/attr_vector_s=
ize.c
> new file mode 100644
> index 0000000..6982922
> --- /dev/null
> +++ b/validation/attr_vector_size.c
> @@ -0,0 +1,7 @@
> +typedef unsigned int u32;
> +typedef u32 __attribute__((vector_size(16))) sse128_t;
> +
> +/*
> + * check-name: attribute vector_size
> + */
> +


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your cod=
e ***
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
