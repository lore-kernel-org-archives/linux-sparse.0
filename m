From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Mon, 22 Dec 2008 19:51:32 -0800
Message-ID: <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <20081218223216.23692.711.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:50031 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbYLWDvc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 22:51:32 -0500
Received: by rv-out-0506.google.com with SMTP id f9so3173526rvb.6
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 19:51:32 -0800 (PST)
In-Reply-To: <20081218223216.23692.711.stgit@zaytsev.su>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Josh Triplett <josh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

Void type is an incomplete type. It should not have storage size.
Program should not depend on sizeof(void) is 1.

Chris

On Thu, Dec 18, 2008 at 2:32 PM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> Gcc assumes sizeof(void) being 1.
> Currently sparse would generate wrong code for:
>
> void *test(void *p) {
>       p++;
>       return p;
> }
>
> unsigned long test1(void *p)
> {
>       return sizeof(*p);
> }
>
> .L0x2b48867c1010:
>       <entry-point>
>       add.32      %r2 <- %arg1, $-1
>       ret.32      %r2
>
> test1:
> .L0x2b48867c10b0:
>       <entry-point>
>       ret.32      $-1
>
> And with bit_size set to &bits_in_char, the code looks
> as expected.
>
> Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
> ---
>  symbol.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/symbol.c b/symbol.c
> index 4da253b..02844cf 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -834,7 +834,7 @@ static const struct ctype_declare {
>        struct symbol *base_type;
>  } ctype_declaration[] = {
>        { &bool_ctype,      SYM_BASETYPE, MOD_UNSIGNED,             &bits_in_bool,           &max_int_alignment, &int_type },
> -       { &void_ctype,      SYM_BASETYPE, 0,                        NULL,                    NULL,               NULL },
> +       { &void_ctype,      SYM_BASETYPE, 0,                        &bits_in_char,           NULL,               NULL },
>        { &type_ctype,      SYM_BASETYPE, MOD_TYPE,                 NULL,                    NULL,               NULL },
>        { &incomplete_ctype,SYM_BASETYPE, 0,                        NULL,                    NULL,               NULL },
>        { &bad_ctype,       SYM_BASETYPE, 0,                        NULL,                    NULL,               NULL },
>
>
