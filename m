From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Updated __nocast vs __bitwise documentation
Date: Thu, 10 May 2012 03:50:26 -0700
Message-ID: <CANeU7QkQtZ9x8xQFWDVPu2tCizWrvmF8EhZE84d6Nok58tnWCQ@mail.gmail.com>
References: <CABG-yt2XiduTbyN+tm++Fw1_s9_QvjFy60=5a--tScMwDT443A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37299 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759020Ab2EJKu1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 06:50:27 -0400
Received: by gglu4 with SMTP id u4so811973ggl.19
        for <linux-sparse@vger.kernel.org>; Thu, 10 May 2012 03:50:26 -0700 (PDT)
In-Reply-To: <CABG-yt2XiduTbyN+tm++Fw1_s9_QvjFy60=5a--tScMwDT443A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Shakthi Kannan <shakthimaan@gmail.com>
Cc: linux-sparse@vger.kernel.org

Looks good. Thanks for doing that.

Can you add some reference (in sparse.txt) to the original Linus email
where some
of this document is base on? Just to give credit where it is due. A lin=
k to the
Linus original email would be perfect.

Thanks

Chris


On Wed, May 9, 2012 at 11:54 PM, Shakthi Kannan <shakthimaan@gmail.com>=
 wrote:
> I have updated the sparse.1 man page including the __bitwise
> relevant content, and created Documentation/sparse.txt with the
> complete comparison between __nocast vs __bitwise.
>
> Signed-off-by: Shakthi Kannan <shakthimaan@gmail.com>
> ---
> =A0Documentation/sparse.txt | =A0 39 ++++++++++++++++++++++++++++++++=
+++++++
> =A0sparse.1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 14 +++++++++++++-
> =A02 files changed, 52 insertions(+), 1 deletions(-)
> =A0create mode 100644 Documentation/sparse.txt
>
> diff --git a/Documentation/sparse.txt b/Documentation/sparse.txt
> new file mode 100644
> index 0000000..37e8916
> --- /dev/null
> +++ b/Documentation/sparse.txt
> @@ -0,0 +1,39 @@
> +Sparse
> +~~~~~~
> +
> +__nocast vs __bitwise:
> +
> +__nocast warns about explicit or implicit casting to different types=
=2E
> +
> +HOWEVER, it doesn't consider two 32-bit integers to be different
> +types, so a __nocast 'int' type may be returned as a regular 'int'
> +type and then the __nocast is lost.
> +
> +So "__nocast" on integer types is usually not that powerful. It just
> +gets lost too easily. It's more useful for things like pointers. It
> +also doesn't warn about the mixing: you can add integers to __nocast
> +integer types, and it's not really considered anything wrong.
> +
> +__bitwise ends up being a "stronger integer separation". That one
> +doesn't allow you to mix with non-bitwise integers, so now it's much
> +harder to lose the type by mistake.
> +
> +So the basic rule is:
> +
> + - "__nocast" on its own tends to be more useful for *big* integers
> +that still need to act like integers, but you want to make it much
> +less likely that they get truncated by mistake. So a 64-bit integer
> +that you don't want to mistakenly/silently be returned as "int", for
> +example. But they mix well with random integer types, so you can add
> +to them etc without using anything special. However, that mixing als=
o
> +means that the __nocast really gets lost fairly easily.
> +
> + - "__bitwise" is for *unique types* that cannot be mixed with other
> +types, and that you'd never want to just use as a random integer (th=
e
> +integer 0 is special, though, and gets silently accepted iirc - it's
> +kind of like "NULL" for pointers). So "gfp_t" or the "safe endiannes=
s"
> +types would be __bitwise: you can only operate on them by doing
> +specific operations that know about *that* particular type.
> +
> +Generally, you want __bitwise if you are looking for type safety.
> +"__nocast" really is pretty weak.
> diff --git a/sparse.1 b/sparse.1
> index bde6b6d..ae85b54 100644
> --- a/sparse.1
> +++ b/sparse.1
> @@ -53,7 +53,19 @@ arithmetic operations other than bitwise
> operations, and on any conversion of
> =A0one restricted type into another, except via a cast that includes
> =A0\fB__attribute__((force))\fR.
>
> -Sparse does not issue these warnings by default.
> +__bitwise ends up being a "stronger integer separation". That one
> +doesn't allow you to mix with non-bitwise integers, so now it's much
> +harder to lose the type by mistake.
> +
> +__bitwise is for *unique types* that cannot be mixed with other
> +types, and that you'd never want to just use as a random integer (th=
e
> +integer 0 is special, though, and gets silently accepted iirc - it's
> +kind of like "NULL" for pointers). So "gfp_t" or the "safe endiannes=
s"
> +types would be __bitwise: you can only operate on them by doing
> +specific operations that know about *that* particular type.
> +
> +Generally, you want bitwise if you are looking for type safety. Spar=
se
> +does not issue these warnings by default.
> =A0.
> =A0.TP
> =A0.B \-Wcast\-to\-as
> --
> 1.7.7.6
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
