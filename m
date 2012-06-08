From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] sparse, llvm: Fix string initializer code generation
Date: Fri, 08 Jun 2012 14:15:33 -0400
Message-ID: <4FD24145.9050209@garzik.org>
References: <1339158877-32024-1-git-send-email-penberg@kernel.org> <1339158877-32024-2-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57523 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758040Ab2FHSPg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 14:15:36 -0400
Received: by yhmm54 with SMTP id m54so1494397yhm.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 11:15:35 -0700 (PDT)
In-Reply-To: <1339158877-32024-2-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

On 06/08/2012 08:34 AM, Pekka Enberg wrote:
> This fixes code generation for string initializer such as:
>
>    static char *foo = "Foo !\n";
>
> It's the same fix Ben proposed earlier with the small difference that we now
> use LLVMTypeOf() instead of symbol_type() to resolve the type.
>
> The generated LLVM IR looks as follows:
>
>    [penberg@tux sparse]$ ./sparse-llvm foo.c |llvm-dis
>    ; ModuleID = '<stdin>'
>
>    @"<noident>" = private global [7 x i8] c"Foo !\0A\00"
>    @foo = private global [7 x i8]* @"<noident>"
>
> Reported-by: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Christopher Li<sparse@chrisli.org>
> Cc: Jeff Garzik<jgarzik@redhat.com>
> Signed-off-by: Pekka Enberg<penberg@kernel.org>
> ---
>   sparse-llvm.c |    6 ++++++
>   1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/sparse-llvm.c b/sparse-llvm.c
> index a39bc02..89c6a2e 100644
> --- a/sparse-llvm.c
> +++ b/sparse-llvm.c
> @@ -1181,6 +1181,12 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
>   				initial_value = output_data(module, sym);
>   			break;
>   		}
> +		case EXPR_STRING: {
> +			const char *s = initializer->string->data;
> +
> +			initial_value = LLVMConstString(strdup(s), strlen(s) + 1, true);
> +			break;
> +		}
>   		default:

ACK 1-2



