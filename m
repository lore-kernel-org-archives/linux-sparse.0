Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100FAC433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 16:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00426120F
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 16:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbhDQQ0d (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Apr 2021 12:26:33 -0400
Received: from avasout06.plus.net ([212.159.14.18]:37109 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbhDQQ0d (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Apr 2021 12:26:33 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Apr 2021 12:26:33 EDT
Received: from satellite ([195.213.6.1])
        by smtp with ESMTPA
        id XneSldz14HBkXXneVlC9fH; Sat, 17 Apr 2021 17:18:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1618676315; bh=LHaZbqdMv4rzU6w2ybspDerKeDftK4TcW9d7UM3SSPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WmAKjq9DWuZwD+feHyoCA7nat2aYrP1ujluuGrIuaJJ+R/bpgPf+ZpFJ4tOmJoAKo
         k0jicsRQBFzzLtmf7BZdKON4Dx7w5lzEtqIqqQEFhvPNj44eUiqod7PH7VBKqfFzqt
         0fvOpkeeb9O4x8PpR2Woai4JWEohKgGeLzOf7VyJ/ChqZc11kL88nDMz3pcEnESXtV
         ck+/X0JdAjwigDNAZqhCVU7lAGmnBLisG2fh2iT+gb9L9crDsCD0l0takFOCpBilCc
         tRXdOrTkjxzXezYYlqImFcg/qAzF8ZTHs/MVTiB/IEo9ZTexUOJR9p6bCwzG6k/2bL
         luY48HqAht0Sw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fI+iIaSe c=1 sm=1 tr=0
 a=v1fZ9eGmBRQ2oAddCs0ezw==:117 a=v1fZ9eGmBRQ2oAddCs0ezw==:17
 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=qfTL1qNhr1dAjFj6Od8A:9 a=CjuIK1q_8ugA:10
X-AUTH: ramsayjones@:2500
Date:   Sat, 17 Apr 2021 17:18:31 +0100
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH] no needs to use MARK_CURRENT_DELETED() for multi-jumps
Message-ID: <YHsKV2s9XW4w8tK9@satellite>
References: <20210417133154.53987-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417133154.53987-1-luc.vanoostenryck@gmail.com>
X-CMAE-Envelope: MS4wfOlHdqRCyC5ScjE8VxxqzSBE0MJhfrTFVxpOU6VBmFmTmot86KvZHf8DFNEYZKqyqj60FQoV5e7XDw7XgoZjJQIB2WnWkQyqj0uskp4nNKECEN3G5sYM
 ns6UzJj64288iWXQsBygzPvVFxAekGAJjSnARDAP65xWtuRbkplqjKuOaejTQXDIJ6rK2/uDPMzOFg==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Apr 17, 2021 at 03:31:54PM +0200, Luc Van Oostenryck wrote:
> MARK_CURRENT_DELETED() was added for the case(s) where an element
> must be removed from the list but the address of the other elements
> must not be changed. In this case of effectively removing the
> element from it list, the element is 'marked' as deleted in the list
> and the list walking macros will later take this in account.
> 
> However, this is not never needed for multi-jumps.

s/not never/not ever/ ?

ATB,
Ramsay Jones

> 
> So, use the usual DELETE_CURRENT_PTR() for them.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  simplify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/simplify.c b/simplify.c
> index 9e3514d838a9..30d053f708e3 100644
> --- a/simplify.c
> +++ b/simplify.c
> @@ -2651,7 +2651,7 @@ static int simplify_cgoto(struct instruction *insn)
>  				continue;
>  			remove_bb_from_list(&jmp->target->parents, bb, 1);
>  			remove_bb_from_list(&bb->children, jmp->target, 1);
> -			MARK_CURRENT_DELETED(jmp);
> +			DELETE_CURRENT_PTR(jmp);
>  		} END_FOR_EACH_PTR(jmp);
>  		kill_use(&insn->src);
>  		insn->opcode = OP_BR;
> -- 
> 2.31.1
> 
