From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] Handle SForced in storage_modifiers
Date: Mon, 14 Nov 2016 21:07:20 -0500
Message-ID: <1479175640.7928.1.camel@redhat.com>
References: <1479150736-28392-1-git-send-email-jlayton@redhat.com>
         <20161114200447.GA15866@macbook.local>
         <CA+55aFxbn+ZAyN9zzcEF60UPoRN2hq86LHk9v5ecqg-c+x3pNw@mail.gmail.com>
         <CANeU7Q=p=kcHCZ2uupc+7e_Gg5uYpe2b2aoS+8nAwyK+jxLtqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33785 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965376AbcKOCH0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Nov 2016 21:07:26 -0500
Received: by mail-qt0-f172.google.com with SMTP id p16so59562822qta.0
        for <linux-sparse@vger.kernel.org>; Mon, 14 Nov 2016 18:07:25 -0800 (PST)
In-Reply-To: <CANeU7Q=p=kcHCZ2uupc+7e_Gg5uYpe2b2aoS+8nAwyK+jxLtqw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>

On Tue, 2016-11-15 at 09:00 +0800, Christopher Li wrote:
> On Tue, Nov 15, 2016 at 4:17 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > The problem is the _size_ of the array. Without that initializer for
> > SForced case, it is one entry too small, and you get a random access
> > past the end of the array.
> > 
> > The patch is definitely correct.
> > 
> 
> Yes, the patch is definitely correct. It is a good catch.
> 
> I purpose a slightly different way to fix it. I think it is better just give the
> array of a size instead of using the designated initializer to determine the
> array size. Sequential initializer to determine the array size is fine.
> 
> Jeff, how about some thing like this:
> 
> Chris
> 
> diff --git a/parse.c b/parse.c
> index 66f9353..a01ba00 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -109,7 +109,7 @@ enum {
>  };
> 
>  enum {
> -       SNone = 0, STypedef, SAuto, SRegister, SExtern, SStatic, SForced
> +       SNone = 0, STypedef, SAuto, SRegister, SExtern, SStatic, SForced, SMax
>  };
> 
>  static struct symbol_op typedef_op = {
> @@ -1279,7 +1279,7 @@ static const char *storage_class[] =
> 
>  static unsigned long storage_modifiers(struct decl_state *ctx)
>  {
> -       static unsigned long mod[] =
> +       static unsigned long mod[SMax] =
>         {
>                 [SAuto] = MOD_AUTO,
>                 [SExtern] = MOD_EXTERN,

That looks fine to me. If you want to merge that one, then:

Reviewed-by: Jeff Layton <jlayton@redhat.com>
