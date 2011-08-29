From: Pekka Enberg <penberg@kernel.org>
Subject: Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Mon, 29 Aug 2011 22:45:41 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1108292242110.24020@localhost6.localdomain6>
References: <4E5495C9.6050207@kernel.org> <CA+55aFwLLn30qohqJeBZLVUYWLKUnbBxnL9u+v=4Fx8TpxDQUQ@mail.gmail.com> <4E55F33C.50203@kernel.org> <CAOJsxLF-=mPSdKLwmc61ZRTQrLGjPTUwVw+PqabYvGKVRwh9sQ@mail.gmail.com> <CAOJsxLFMz7fs4ySkizHk43a0fz9VKS5ReWXoJa8cy2AQ6iwRng@mail.gmail.com>
 <CA+55aFywG3vBA87W2h1f=-H144MTZesEwp5jVu8ndyBfLX7Sbg@mail.gmail.com> <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6> <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com> <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
 <alpine.DEB.2.00.1108252310490.22479@localhost6.localdomain6> <CA+55aFy3TUT=BFD+Nb9H6uDBhz427kC4tBc+ehQDs6JBggTuHQ@mail.gmail.com> <4E573A3E.6060104@kernel.org> <CA+55aFzbV0OvrtkzbjxvL1tkfF=+6xbBsyWb8XtAcK-YNeKjZw@mail.gmail.com>
 <alpine.DEB.2.00.1108271214410.14365@localhost6.localdomain6> <CA+55aFzbfD4RDe52HCL9mfSYMzFdvP96OiK5ifkfUKNkzjJNrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463808768-1318521429-1314647147=:24020"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58350 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab1H2Tpv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 15:45:51 -0400
Received: by bke11 with SMTP id 11so4446326bke.19
        for <linux-sparse@vger.kernel.org>; Mon, 29 Aug 2011 12:45:50 -0700 (PDT)
In-Reply-To: <CA+55aFzbfD4RDe52HCL9mfSYMzFdvP96OiK5ifkfUKNkzjJNrg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808768-1318521429-1314647147=:24020
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

[ Adding sparse-linux to CC. ]

On Sat, 27 Aug 2011, Linus Torvalds wrote:
> On Sat, Aug 27, 2011 at 2:19 AM, Pekka Enberg <penberg@kernel.org> wrote:
>>
>> Looking at this:
>>
>> sete:
>> .L0x7f188cf71c90:
>>        <entry-point>
>>        seteq.32    %r83 <- %arg1, %arg2
>>        cast.32     %r84 <- (8) %r83
>>        ret.32      %r84
>>
>> Why do we have "seteq.32" there but then we have a "cast.32" from %r83 which
>> is 8 bits? Isn't it linearize.c that's confused here?
>
> No, the code is correct, you misunderstand what "seteq" does.
>
> The 32 in "seteq.32" is the OPERAND WIDTH. It takes two 32-bit values
> and checks that they are equal.
>
> The OUTPUT WIDTH is "boolean". Which you changed to 8 bits (to match
> x86 semantics). So when you return an "int", you do indeed need to
> cast from 8 bits to 32 bits.
>
> There are a few ops that have different operand width from output
> width. The cast operation itself is the obvious case, and it shows its
> operand/output widths explicitly. But "setcc" is another - since the
> output is always just a boolean.

So you were obviously correct. I checked the LLVM bitcode and I was simply 
using the wrong type of cast. With this small change:

diff --git a/sparse-llvm.c b/sparse-llvm.c
index f89f7a7..a9bf679 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -607,7 +607,7 @@ static void output_op_cast(struct function *fn, struct instruction *insn)
  	if (symbol_is_fp_type(insn->type))
  		target = LLVMBuildFPCast(fn->builder, src, symbol_type(insn->type), target_name);
  	else
-		target = LLVMBuildIntCast(fn->builder, src, symbol_type(insn->type), target_name);
+		target = LLVMBuildZExt(fn->builder, src, symbol_type(insn->type), target_name);

  	insn->target->priv = target;
  }

the generated code now looks sane:

0000000000000000 <sete>:
    0:	39 f7                	cmp    %esi,%edi
    2:	0f 94 c0             	sete   %al
    5:	0f b6 c0             	movzbl %al,%eax
    8:	c3                   	retq
    9:	eb 05                	jmp    10 <setne>

However, i'm not 100% sure that's sufficient. Is OP_CAST always 
zero-extend or do we need to check for something specific here?

 			Pekka
---1463808768-1318521429-1314647147=:24020--
