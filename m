From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] fix casts when linearizing compound assignments
Date: Fri, 8 Jun 2012 11:45:22 -0400
Message-ID: <56898225-DCA7-465E-BFD8-7D9D084A243B@gmail.com>
References: <1339152460-17411-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f194.google.com ([209.85.161.194]:44633 "EHLO
	mail-gg0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296Ab2FHQ4D (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 12:56:03 -0400
Received: by ggdk5 with SMTP id k5so222350ggd.1
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 09:56:01 -0700 (PDT)
In-Reply-To: <1339152460-17411-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>

On Jun 8, 2012, at 6:47 AM, Xi Wang wrote:
> -		oldvalue = cast_pseudo(ep, oldvalue, src->ctype, expr->ctype);
> -		opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], src->ctype);
> -		dst = add_binary_op(ep, src->ctype, opcode, oldvalue, value);
> -		value = cast_pseudo(ep, dst, expr->ctype, src->ctype);
> +		opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], expr->ctype);
> +		value = cast_pseudo(ep, value, src->ctype, expr->ctype);
> +		value = add_binary_op(ep, expr->ctype, opcode, oldvalue, value);

For sparse-llvm, is it better to get rid of the cast_pseudo()
at all?

For example, what to emit for p += 1:

1) pointer p + integer 1,

2) pointer + pointer [cast from integer], or

3) (pointer)(integer [cast from pointer] + integer)?

- xi
