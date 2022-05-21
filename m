Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71738C433EF
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 21:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbiEUVq0 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 17:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiEUVqY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 17:46:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211711169
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 14:46:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j28so14669519eda.13
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VHGsf0YyG6Aj9z0V/K+AfvfUR5qIHJefbUxdIwAxb9s=;
        b=JRIVUeUMYlj7uImqOiKv1dkq2kgDlrbKfF7lB39OFLEHl0V0a3mZ44SHijmddwx7KZ
         Hf8JHB8wsNpe45qMnRMq2UcEpFvI3nK2kcA+UoYo29b2h1N7kAba0TqePsaubplmG6Wg
         ljJ1aEY2n38aoXWxbRuo6NMjnSzD7ZoFemLOwoplb3H6ZtHnrmArz2xxKqOMTBaMNh6q
         xM7QPOadHNsguwunliVv4+kGVYbgR3BWoeynECtj77B1TuRw57c4QhfJxVnrO5SWDEFT
         BiSSj7okmnFDnAacEnrS4X+/Ay7s/9O9BsYSR3/lo88HYFaIbA/TcSZG9dR1bYz+Vnbo
         bRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VHGsf0YyG6Aj9z0V/K+AfvfUR5qIHJefbUxdIwAxb9s=;
        b=BNIBBfeRX9P96CmQ7L5+RdVb5kxlS9Uve2pau8/cIyyMkX6eHKe//V4gCQnv0M29qi
         cc2XWXT8qnQmSc9JNcl2Ks2AKsQGOZWPtQcN0TXOTE7JH0FKAiSfS0XmiZsf7ydqLAjD
         A2QQR1z2hiL4GXV2rF+aUgY2lCGtwSqmq17IKzJyu2NOlZd3R3onUjivCSzy+EJHOg1V
         zEbx7xIjj9vfc0TL4E4cfCCYWq6st2X0UihH8ukxlNSoi0mXMhINZi71fExdkc3+2HTU
         YkLmHlNGRsh/PEHq1CwWIahZ0dRaSNe5UXIchX6Ru+AS/wxBFzgyIIRubLyEYrg8DlBq
         L/MA==
X-Gm-Message-State: AOAM532KjHrntnG2kWAPIxQFx4rUJXVUPc9QoIR9BLNww6WwKZjkRJVd
        lQU/y2QSKsYU33cdNIaGaiU=
X-Google-Smtp-Source: ABdhPJxIQlEX/ftbLHv6wkeMMg7xV2sFqNh3JR9vWGbfjbovtl9HUFZAs9mES9dqn3Jb/wOsFHqDHA==
X-Received: by 2002:aa7:cd70:0:b0:42a:f084:5fba with SMTP id ca16-20020aa7cd70000000b0042af0845fbamr17369759edb.351.1653169580906;
        Sat, 21 May 2022 14:46:20 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006fe7b0e124esm4625030ejc.18.2022.05.21.14.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 14:46:20 -0700 (PDT)
Date:   Sat, 21 May 2022 23:46:18 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, mkl@pengutronix.de,
        aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 1/6] RISC-V: Respect -Wsparse-error for -march errors
Message-ID: <20220521214618.2i5xokersg3hhzfn@mail>
References: <20220402050041.21302-1-palmer@rivosinc.com>
 <20220402050041.21302-2-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402050041.21302-2-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Apr 01, 2022 at 10:00:36PM -0700, Palmer Dabbelt wrote:
> Parsing RISC-V ISA strings is extremely complicated: there are many
> extensions, versions of extensions, versions of the ISA string rules,
> and a bunch of unwritten rules to deal with all the bugs that fell out
> of that complexity.
> 
> Rather than forcing users to see an error when the ISA string parsing
> fails, just stop parsing where we get lost.  Changes tend to end up at
> the end of the ISA string, so that's probably going to work (and if
> it doesn't there's a warning to true and clue folks in).
> 
> This does have the oddity in that "-Wsparse-error -march=..." behaves
> differently than "-march... -Wsparse-error", but that's already the case
> for "--arch=... -march=..." and "-march=... --arch=...".  Both
> "-Wsparse-error" and "--arch" are sparse-specific arguments, so they're
> probably both going to be in the same place.
> 
> diff --git a/target-riscv.c b/target-riscv.c
> index 6d9113c1..f5cc6cc3 100644
> --- a/target-riscv.c
> +++ b/target-riscv.c
> @@ -60,7 +61,18 @@ static void parse_march_riscv(const char *arg)
>  			goto ext;
>  		}
>  	}
> -	die("invalid argument to '-march': '%s'\n", arg);
> +
> +unknown:
> +	/*
> +	 * This behaves like do_warn() / do_error(), but we don't have a
> +	 * position so it's just inline here.
> +	 */
> +	fflush(stdout);
> +	fprintf(stderr, "%s: invalid argument to '-march': '%s'\n",
> +		Wsparse_error == FLAG_ON ? "error" : "warning", arg);
> +	if (Wsparse_error == FLAG_ON)
> +		has_error |= ERROR_CURR_PHASE;
> +	return;

I don't like this because:
1) it's way too much intimate with the way options are parsed
   (enum flag_type should stay local to options.c).
2) -Wsparse-error is a kind of hack to ignore -Werror but keep
   a way to invoke its semantic (but I don' think anyone is using it).
3) I don't think -Wsparse-error (or GCC's -Werror) should be concerned
   with the parsing of options.

I think it would be fine, for now, to always simply report a warning,
like Linus' patch (but I would prefer to just handle the correct parsing).
If reporting an error is important, then I would be happy to jut move
this code into an helper defined in "options.c".

Best regards,
-- Luc
