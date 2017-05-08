From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v6] sparse: add support for _Static_assert
Date: Tue, 9 May 2017 01:25:10 +0200
Message-ID: <20170508232509.j77fpn3ffof5tppd@desk.local>
References: <20170508211543.20681-1-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35071 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdEHXZP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 8 May 2017 19:25:15 -0400
Received: by mail-wm0-f54.google.com with SMTP id b84so72102899wmh.0
        for <linux-sparse@vger.kernel.org>; Mon, 08 May 2017 16:25:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170508211543.20681-1-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Mon, May 08, 2017 at 05:15:43PM -0400, Lance Richardson wrote:
> This patch introduces support for the C11 _Static_assert() construct.

For me, it's fine.
I just have a small remarks (see below).
 
> @@ -1945,13 +1953,17 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
>  static struct token *struct_declaration_list(struct token *token, struct symbol_list **list)
>  {
>  	while (!match_op(token, '}')) {
> -		if (!match_op(token, ';'))
> -			token = declaration_list(token, list);
> -		if (!match_op(token, ';')) {
> -			sparse_error(token->pos, "expected ; at end of declaration");
> -			break;
> +		if (match_ident(token, &_Static_assert_ident))
> +			token = parse_static_assert(token, NULL);

I find it better with a 'continue' here

> +		else {

so, this 'else' become unneeded and there is no
more needs to move the previous content of the loop
(which help a lot when reviewing patches or when
digging in the history).

-- Luc
