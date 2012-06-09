From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [RFC/PATCH] sparse, llvm: Fix string globals access
Date: Sat, 9 Jun 2012 07:46:04 -0400
Message-ID: <29B320C9-0B72-40F2-A332-07AA4FC9B3C7@gmail.com>
References: <1339160327-8534-1-git-send-email-penberg@kernel.org> <4FD240E2.6040003@garzik.org> <CAOJsxLH9N84YwLrHQXn+R1r4cOd7DUuM2SpFq828mSV6WmHjqg@mail.gmail.com> <35CC6868-F462-4116-A143-81959DA38D5C@gmail.com> <CAOJsxLFX-ZiDCQ84uKka4MYa_uUhLMPeR=XWAHMevTRFsfZBJA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47640 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab2FILqI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2012 07:46:08 -0400
Received: by yhmm54 with SMTP id m54so1806835yhm.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jun 2012 04:46:08 -0700 (PDT)
In-Reply-To: <CAOJsxLFX-ZiDCQ84uKka4MYa_uUhLMPeR=XWAHMevTRFsfZBJA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>


On Jun 9, 2012, at 7:00 AM, Pekka Enberg wrote:
> 
> Right. Looking at your "splay" backend
> 
> static value_t emit_gep(builder_t builder, struct pseudo *src,
> unsigned int offset, struct pseudo *dst)
> {
> 	type_t charp = LLVMPointerType(LLVMInt8Type(), 0);
> 	value_t base = LLVMBuildPointerCast(builder, emit_pseudo(src), charp, "");
> 	value_t idx = LLVMConstInt(LLVMIntType(bits_in_pointer), offset, 0);
> 	value_t gep = LLVMBuildGEP(builder, base, &idx, 1, "");
> 	type_t type = LLVMPointerType(emit_type(dst->ctype), 0);
> 
> 	return LLVMBuildPointerCast(builder, gep, type, "");
> }
> 
> after which OP_LOAD translation becomes as simple as
> 
> 	case OP_LOAD:
> 		return LLVMBuildLoad(builder, emit_gep(builder, insn->src,
> insn->offset, insn->target), "");
> 
> Jeff, I guess we should do this for output_load() and output_store()
> in sparse-llvm.c as well?

Maybe we can do this for "pointer + integer" as well, using getelementptr
with offset computed by sparse (converting the pointer to char* first).
Unlike inttoptr/ptrtotint, this shouldn't disable LLVM's alias analysis.
I will give it a try later.

- xi
