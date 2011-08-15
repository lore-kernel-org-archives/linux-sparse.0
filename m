From: Christopher Li <sparse@chrisli.org>
Subject: Re: more "unreplaced symbol" warnings
Date: Mon, 15 Aug 2011 12:34:38 -0700
Message-ID: <CANeU7QnUQdV4G5zNQ6QwHtGj1e=+fy5P7SmhyUeRTMvujaRMVQ@mail.gmail.com>
References: <20110529145450.8c042971.rdunlap@xenotime.net>
	<BANLkTi=_0Xe8Fuq9aJ69Zqx3iQYq6E9N5w@mail.gmail.com>
	<20110531185831.GN11521@ZenIV.linux.org.uk>
	<BANLkTingWZfcrf3iKZw8_vMwECm4jYnNgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:65374 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1HOTej convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 15 Aug 2011 15:34:39 -0400
Received: by qyk34 with SMTP id 34so2977201qyk.19
        for <linux-sparse@vger.kernel.org>; Mon, 15 Aug 2011 12:34:38 -0700 (PDT)
In-Reply-To: <BANLkTingWZfcrf3iKZw8_vMwECm4jYnNgQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Wed, Jun 1, 2011 at 12:41 AM, Christopher Li <sparse@chrisli.org> wr=
ote:
> #define __u16 unsigned short
> int foo(__u16 n);
> static inline __u16 f(__u16 val)
> {
> =A0 =A0 =A0 =A0return val;
> }
>
> static inline unsigned int bar(__u16 n)
> {
> =A0 =A0 =A0 switch (n) {
> =A0 =A0 =A0 case (1 ? 1 : f(1)):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 4;
> =A0 =A0 =A0 }
> }
>
> int foo(__u16 n)
> {
> =A0 =A0 =A0 =A0bar(n);
> =A0 =A0 =A0 =A0bar(n);
> =A0 =A0 =A0 =A0return 0;
> }

I just submit a fix for this bug. It took me a few days staring at the
inlining code to figure out what is going on. I am glad this is bug is
resolved now.

The example above is actually the minimal setup to trigger this
bug. The root cause is in one of the member during copying case stateme=
nt
did not replace to the new statement. e.g. when inlining f(), it actual=
ly
change the original copy of function definition in bar().

The warning is triggered during the second time bar() get inlined.

The fix is just one line. Finding it is the hard part.

Chris

@@ -381,6 +381,7 @@ static struct statement *copy_one_statement(struct
statement *stmt)
        case STMT_CASE: {
                stmt =3D dup_statement(stmt);
                stmt->case_label =3D copy_symbol(stmt->pos, stmt->case_=
label);
+               stmt->case_label->stmt =3D stmt;
                stmt->case_expression =3D copy_expression(stmt->case_ex=
pression);
                stmt->case_to =3D copy_expression(stmt->case_to);
                stmt->case_statement =3D copy_one_statement(stmt->case_=
statement);
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
