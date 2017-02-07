From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC/PATCH] arm64: Rename macro arguments to silence sparse
Date: Mon, 6 Feb 2017 17:08:17 -0800
Message-ID: <d5bb9d5a-5b02-ffab-d404-bbda532b6c76@codeaurora.org>
References: <20170207010143.22371-1-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdBGBIT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Feb 2017 20:08:19 -0500
In-Reply-To: <20170207010143.22371-1-sboyd@codeaurora.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/06/2017 05:01 PM, Stephen Boyd wrote:
> When I compile files with sparse, I get these sorts of warnings:
>
> arch/arm64/include/asm/lse.h:14:28: warning: Unknown escape 'l'
> arch/arm64/include/asm/lse.h:14:37: warning: Unknown escape 'l'
> arch/arm64/include/asm/alternative.h:172:28: warning: Unknown escape 'o'
>
> This is because sparse is trying to tokenize these files and sees
> a line like this:
>
>  alternative_insn "\llsc", "\lse", ARM64_HAS_LSE_ATOMICS
>
> It gets past alternative_insn part and then sees the start of a
> string with the double quote character. So sparse starts to parse
> the string (eat_string() in the sparse code) but the string has
> an escape character '\' in it. Sparse sees the escape character,
> so it checks to see if it's an escape sequence, but '\l' isn't.
> This causes sparse to spit out this warning of an unknown escape
> sequence 'l'.
>
> In reality, sparse isn't going to use these macros anyway because
> this whole thing is inside an __ASSEMBLER__ ifdef. One hacky
> solution is to make sparse think it actually is an escape
> sequence by starting the macro arguments with the 'n' character.
> Then sparse will see a \n inside a string, which keeps it silent
> and the assembler doesn't seem to mind either.
>
> Cc: <sparse@vger.kernel.org>

Sorry, supposed to be <linux-sparse@vger.kernel.org>

> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm64/include/asm/alternative.h | 4 ++--
>  arch/arm64/include/asm/lse.h         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index 6e1cb8c5af4d..dd393db554c8 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -168,8 +168,8 @@ alternative_endif
>  #define _ALTERNATIVE_CFG(insn1, insn2, cap, cfg, ...)	\
>  	alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
>  
> -.macro user_alt, label, oldinstr, newinstr, cond
> -9999:	alternative_insn "\oldinstr", "\newinstr", \cond
> +.macro user_alt, label, noldinstr, newinstr, cond
> +9999:	alternative_insn "\noldinstr", "\newinstr", \cond
>  	_ASM_EXTABLE 9999b, \label
>  .endm
>  
> diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
> index fc756e22c84c..36206d75943d 100644
> --- a/arch/arm64/include/asm/lse.h
> +++ b/arch/arm64/include/asm/lse.h
> @@ -10,8 +10,8 @@
>  
>  .arch_extension	lse
>  
> -.macro alt_lse, llsc, lse
> -	alternative_insn "\llsc", "\lse", ARM64_HAS_LSE_ATOMICS
> +.macro alt_lse, nllsc, nlse
> +	alternative_insn "\nllsc", "\nlse", ARM64_HAS_LSE_ATOMICS
>  .endm
>  
>  #else	/* __ASSEMBLER__ */

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

