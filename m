Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CEE19F137
	for <linux-sparse@vger.kernel.org>; Mon, 19 Jan 2026 00:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768782128; cv=none; b=udxw4OfmJlbrlXjobGv6o5/WagKVbsoXDrRNAKov5syjBk5itHgQ8piEXachzF+6vS7XVAzfZMWOU4IBibzLyeKU15IZOivbASUxvBBSpbQMqGVojk8vp4wIMAU4fg4/pjwQdmQi11MlMzWC0iFjiZOccLXJoLBU9TqKyMh8wPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768782128; c=relaxed/simple;
	bh=e8GQMjVdsCRjMCUq47u6baf2oZi/9SEJV4+WmlS6ASo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE5M1jkYjEMGM9ElCuzkH87i8b8a4EWQDriacHPjsdi70VvNih2Kos+3JbMVU+moazvJaClQjxhrf9/alAXp+F/gcv6TAKpJYuVrqTupdTvkMCXRfR2CsNuglyT7pnIfb2iqGuvwzEOiTi/cZl4BYv0UD0kz0bvsc2wbGhUSOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79028cb7f92so28968837b3.2
        for <linux-sparse@vger.kernel.org>; Sun, 18 Jan 2026 16:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768782126; x=1769386926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMHJPEiHX/LiXy4sX99PvOXdvzcmZQweJFjed/VS+yA=;
        b=fptdFnhgIa3SMBbdPR4UypExrgqTTsdLoFWoSM9vkk2E578abaoiFXdBTW6gLusnAK
         FA/ls2L4M0m2PLZFg5BzpQynIIEkJ0t3vwG654XwKgSx/6WGcFqirb3ZCrKAkTSLiQmy
         7FpVPrhltYQCf78BHZsAdrDyX+Qn9drQLJAUKATUKvMyw6yprLTt5oU5rIP2+9eY2UKb
         ZlqoV/sH04hq6vm5AkjF3IsJ718m/2b1PBnQWUIcUT4skFJvgQGFEymNiko54aaN6jLN
         tdVs4KF4f6FMyzJ1NOWN9hfTLww8B1QHM4tiTwvgdyMIp1igL4P3TtkH8oBMXAzhBwIs
         Quag==
X-Forwarded-Encrypted: i=1; AJvYcCWqQyf1QlQrvIezrUWGEWKboW0DYyhgPfl3furp14SsUPzdqU6uvg3q+wMWz7Nhm5Lp89MYxZltbgFegUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdmrfa91wDwYGMIleQg8mdNsBfiRAQiPLoTPGAvrQLKo1MLKpS
	id1XWTWwXRgB3a5T/DJTHeJQwQkELjowUQK0HBU+643jhMSayDYdcVeN0GbztyHzWkx6NHPlT4j
	HPuK5OOJBnbsbxb/ZxXCflpkoG53ykJinS6RnddWX7A==
X-Gm-Gg: AZuq6aLwF6N6K1MO7+XiOIbnIznrlds5glVK/AFfWlwt8Vvf4v/qEuqVVy1MljNEk7d
	5+en1PKHkn8jBq22VkNN8gBw73wQAobVy0etlJkDbhL7I3EftZA7xyqFsDDuriNhJkYoE24maIi
	KsE0xPTT0uCa35pVCZo2eoIhV1UnIDtcOkSmMWhPv+GU9AGiF1bPr3Cv6H152xAqoOuJZXkBmn7
	6ARosxNwW38enc51yVYdXU6/LfU6rFrOrwg9hwJ294yBhpAuFguAKrQ053w7B9V+u0rp7EkMmqs
	qob8VJKsNwmMHGuhRTPf5Jwfjg==
X-Received: by 2002:a05:690c:3382:b0:793:aeb2:ef51 with SMTP id
 00721157ae682-793c6833710mr71276397b3.51.1768782126264; Sun, 18 Jan 2026
 16:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aULJmGi8yib_XH0P@redhat.com> <CACePvbW2OybP7P-Vk+pa23SqA0+R0i8=20TiQMq99PvNAYJ8GA@mail.gmail.com>
 <aWuagcDh53AQxEmw@redhat.com>
In-Reply-To: <aWuagcDh53AQxEmw@redhat.com>
From: Chris Li <sparse@chrisli.org>
Date: Sun, 18 Jan 2026 16:21:54 -0800
X-Gm-Features: AZwV_Qj_ajJRJgV9l2p5GTtfnex3DWYqlXy4HtMXDttPJA3Mkzwx2FnBEKLcxCY
Message-ID: <CACePvbWe8FoUjKvtaAyBtVdurMOE=c9zDuX_eNfGqouaQ0kDFg@mail.gmail.com>
Subject: Re: [PATCH] sparse/pre-process: introduce "dissect_mode" option to
 fix dissect/semind
To: Oleg Nesterov <oleg@redhat.com>
Cc: Luc Van Oostenryck <lucvoo@kernel.org>, Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 6:19=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Hi Chris,
>
> On 01/16, Chris Li wrote:
> >
> > On Wed, Dec 17, 2025 at 7:26=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > I don't quite understand why does expand() -> collect_arg() path
> > > update ->pos for each token in the input *list, but this breaks
> > > dissect and thus semind.
> >
> > That is a good question, I don't understand why it did that either. I
> > did some digging, inside macro argument list expansion, the "#include
> > " is not allowed. It is not possible to switch streams here. The
> > "pos.pos" is for human consumption anyway, it has no effect on the IR
> > generation. The only visible effect as far as I can tell is related to
> > the preprocessor "-E" in lib.c:
> >
> >         if (preprocess_only) {
> >                 while (!eof_token(token)) {
> >                         int prec =3D 1;
> >                         struct token *next =3D token->next;
> >                         const char *separator =3D "";
> >                         if (next->pos.whitespace)
> >                                 separator =3D " ";
> >                         if (next->pos.newline) {
> >                                 separator =3D "\n\t\t\t\t\t";
> >                                 prec =3D next->pos.pos; <--- use pos as
> > indentation level.
> >                                 if (prec > 4)
> >                                         prec =3D 4;
> >                         }
> >                         printf("%s%.*s", show_token(token), prec, separ=
ator);
> >                         token =3D next;
> >
> > The "-E" output has some indentation enhancement to turn space into
> > tab level indentation. This "pos" assignment tries to align the
> > indentation context of the input arguments to the same level of the
> > expanding macro name.
>
> Yes, exactly! Initially I tried to simply remove these next->pos.* update=
s
> in collect_arg(), but this causes a lot of failures in validation/preproc=
essor
> (due to extra indentations) and I failed to find a simple fix for the
> "if (preprocess_only)" code above. Plus I wasn't comfortable because
> I don't understand the intent...

As far as I can tell, the new position report is more useful to the
reader. I haven't heard any objections yet. Let's put it on the
sparse-dev for a bit then merge into sparse. In the worst case there
is some burning reason to use the old behavior, we can always change
the behavior back. It is only  software and it is easy to fix.

>
> > >  void dissect(struct reporter *rep, struct string_list *filelist)
> > >  {
> > > +       dissect_mode =3D 1;
> >
> > I don't think we need dissect_mode. I am leaning towards enabling it
> > all the time, maybe except for the preprocessor only mode.
>
> ...
>
> > > +               if (!dissect_mode) {
> > > +                       next->pos.stream =3D pos->stream;
> > > +                       next->pos.line =3D pos->line;
> > > +                       next->pos.pos =3D pos->pos;
> > > +               }
> >
> > Maybe change it to "if (preprocess_only)", and fix all the validation
> > error output of the checker. What do you say?
>
> Agreed! This was my plan B ;)
>
> With this change
>
>         -               if (!dissect_mode) {
>         +               if (preprocess_only) {
>
> make check reports 2 failures
>
>         -parsing/attr-cleanup.c:10:17: error: argument is not an identifi=
er
>         +parsing/attr-cleanup.c:10:27: error: argument is not an identifi=
er
>
>         -sizeof-void.c:20:14: warning: expression using sizeof(void)
>         +sizeof-void.c:20:27: warning: expression using sizeof(void)
>
> but the new positions look more correct.
>
> However. I didn't dare to send this patch because other warnings from
> sizeof-void.c still blame the column 14, this looks inconsistent...
> But perhaps we don't really care?

Well, we care in the sense that we don't want unnecessary check
failures. But we can update the expected output of the validation
check to silence the error.

>
> So. I am going to update the changelog and send the trivial V2 below.
>
> Will you agree?

Agree. As far as I can tell. The new position is more desirable. Let's
switch to the new position.

Chris

>
> Oleg.
> ---
>
> diff --git a/pre-process.c b/pre-process.c
> index 3fb25082..a4bb6cb6 100644
> --- a/pre-process.c
> +++ b/pre-process.c
> @@ -294,9 +294,11 @@ static struct token *collect_arg(struct token *prev,=
 int vararg, struct position
>                 } else if (match_op(next, ',') && !nesting && !vararg) {
>                         break;
>                 }
> -               next->pos.stream =3D pos->stream;
> -               next->pos.line =3D pos->line;
> -               next->pos.pos =3D pos->pos;
> +               if (preprocess_only) {
> +                       next->pos.stream =3D pos->stream;
> +                       next->pos.line =3D pos->line;
> +                       next->pos.pos =3D pos->pos;
> +               }
>                 next->pos.newline =3D 0;
>                 p =3D &next->next;
>         }
> diff --git a/validation/parsing/attr-cleanup.c b/validation/parsing/attr-=
cleanup.c
> index ac64649c..fa3cb1ca 100644
> --- a/validation/parsing/attr-cleanup.c
> +++ b/validation/parsing/attr-cleanup.c
> @@ -24,7 +24,7 @@ int test(int n)
>   * check-command: sparse -Wunknown-attribute $file
>   *
>   * check-error-start
> -parsing/attr-cleanup.c:10:17: error: argument is not an identifier
> +parsing/attr-cleanup.c:10:27: error: argument is not an identifier
>  parsing/attr-cleanup.c:11:39: error: an argument is expected for attribu=
te 'cleanup'
>  parsing/attr-cleanup.c:12:40: error: an argument is expected for attribu=
te 'cleanup'
>  parsing/attr-cleanup.c:13:43: error: Expected ) after attribute's argume=
nt'
> diff --git a/validation/sizeof-void.c b/validation/sizeof-void.c
> index 0fd917a2..6792ff02 100644
> --- a/validation/sizeof-void.c
> +++ b/validation/sizeof-void.c
> @@ -36,7 +36,7 @@ sizeof-void.c:16:14: warning: expression using sizeof(v=
oid)
>  sizeof-void.c:17:14: warning: expression using sizeof(void)
>  sizeof-void.c:18:14: warning: expression using sizeof(void)
>  sizeof-void.c:19:14: warning: expression using sizeof(void)
> -sizeof-void.c:20:14: warning: expression using sizeof(void)
> +sizeof-void.c:20:27: warning: expression using sizeof(void)
>  sizeof-void.c:21:14: warning: expression using sizeof(void)
>  sizeof-void.c:22:14: warning: expression using sizeof(void)
>  sizeof-void.c:23:14: warning: expression using sizeof(void)
>
