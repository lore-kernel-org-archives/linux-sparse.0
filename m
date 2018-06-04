From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 2/9] x86: objtool: use asm macro for better compiler
 decisions
Date: Mon, 4 Jun 2018 14:04:25 -0500
Message-ID: <20180604190425.iam6ik5zrjf4wk6v@treble>
References: <20180604112131.59100-1-namit@vmware.com>
 <20180604112131.59100-3-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180604112131.59100-3-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Jun 04, 2018 at 04:21:24AM -0700, Nadav Amit wrote:
> +#ifdef CONFIG_STACK_VALIDATION
> +.macro ANNOTATE_UNREACHABLE counter:req
> +\counter:
> +	.pushsection .discard.unreachable
> +	.long \counter\()b -.
> +	.popsection
> +.endm
> +
> +.macro ANNOTATE_REACHABLE counter:req
> +\counter:
> +	.pushsection .discard.reachable
> +	.long \counter\()b -.
> +	.popsection
> +.endm
> +
> +.macro ASM_UNREACHABLE
> +999:
> +	.pushsection .discard.unreachable
> +	.long 999b - .
> +	.popsection
> +.endm
> +#else /* CONFIG_STACK_VALIDATION */
> +.macro ANNOTATE_UNREACHABLE counter:req
> +.endm
> +
> +.macro ANNOTATE_UNREACHABLE counter:req
> +.endm
> +
> +.macro ASM_UNREACHABLE
> +.endm /* CONFIG_STACK_VALIDATION */
> +#endif

The '/* CONFIG_STACK_VALIDATION */' comment is on the wrong line.

Otherwise:

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
