From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] Fix build with GCC 4.6 series.
Date: Thu, 14 Apr 2011 02:58:53 -0700
Message-ID: <BANLkTi=Xg8Zy7TyCqD=LXLxvWZoS79cEYw@mail.gmail.com>
References: <1302692766-30217-1-git-send-email-flameeyes@gmail.com>
	<1302692766-30217-3-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52590 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382Ab1DNJ6y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 14 Apr 2011 05:58:54 -0400
Received: by vws1 with SMTP id 1so1146492vws.19
        for <linux-sparse@vger.kernel.org>; Thu, 14 Apr 2011 02:58:54 -0700 (PDT)
In-Reply-To: <1302692766-30217-3-git-send-email-flameeyes@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Diego_Elio_Petten=F2?= <flameeyes@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Will apply.

Chris

On Wed, Apr 13, 2011 at 4:06 AM, Diego Elio Petten=F2 <flameeyes@gmail.=
com> wrote:
> The label_statement attribute in the anonymous structures' union was
> duplicated for label_arg and labeled_struct alises, which were
> identical. Since the former is never used, delete it and leave the ot=
her as
> the only copy.
> ---
> =A0parse.h | =A0 =A04 ----
> =A01 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/parse.h b/parse.h
> index 6b21e23..b26bd03 100644
> --- a/parse.h
> +++ b/parse.h
> @@ -35,10 +35,6 @@ struct statement {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct /* declaration */ {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct symbol_list *de=
claration;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct /* label_arg */ {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct symbol *label;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct statement *label=
_statement;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct expression *exp=
ression;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct expression *con=
text;
> --
> 1.7.5.rc1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
