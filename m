From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] sparse, llvm: Simplify comparison op code generation
Date: Tue, 22 Nov 2011 20:18:54 +0200
Message-ID: <CAOJsxLFNzP0kBQwZkx3yQHLj4LL__Nkw_78i6aDpRU053J-3pA@mail.gmail.com>
References: <1321984717-22395-1-git-send-email-penberg@kernel.org>
	<CA+55aFy9S2j2YbdwLxmYb+K4eRR61wn0Q9D3JodFL0xdYwMhgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49250 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1KVSSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 13:18:55 -0500
Received: by vcbfk1 with SMTP id fk1so527060vcb.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 10:18:54 -0800 (PST)
In-Reply-To: <CA+55aFy9S2j2YbdwLxmYb+K4eRR61wn0Q9D3JodFL0xdYwMhgg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

> On Tue, Nov 22, 2011 at 9:58 AM, Pekka Enberg <penberg@kernel.org> wr=
ote:
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Nov 22, 2011 at 8:05 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Hey, I obviously like it since I suggested it, but I wonder if you
> shouldn't handle the FP cases too?
>
> You have lost the
>
> =A0assert(!symbol_is_fp_type(insn->type));
>
> but I do suspect that the same code should be able to largely just
> handle the FP cases (you'd obviously need to translate the sparse
> OP_SET_NE things into the proper LLVM LLVMfpEQ or whatever LLVM does)=
=2E
>
> That said, if you don't handle the FP cases, I think you should
> re-introduce the assert().

Actually, the assert() doesn't catch anything. With something like this=
:

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 4ef02a1..3806876 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -514,6 +514,8 @@ static void output_op_binary(struct function *fn,
struct instruction *insn)
        case OP_BINCMP ... OP_BINCMP_END: {
                LLVMIntPredicate op =3D translate_op(insn->opcode);

+               assert(!symbol_is_fp_type(insn->type));
+
                target =3D LLVMBuildICmp(fn->builder, op, lhs, rhs, tar=
get_name);
                break;
        }
diff --git a/validation/backend/cmp-ops.c b/validation/backend/cmp-ops.=
c
index 7bbc81c..d8b5e9a 100644
--- a/validation/backend/cmp-ops.c
+++ b/validation/backend/cmp-ops.c
@@ -8,6 +8,11 @@ static int setne(int x, int y)
        return x !=3D y;
 }

+static int fsetl(float x, float y)
+{
+       return x < y;
+}
+
 static int setl(int x, int y)
 {
        return x < y;

You hit this assertion in LLVM:

[penberg@tux sparse]$ ./sparse-llvm validation/backend/cmp-ops.c
sparse-llvm: /home/penberg/llvm/include/llvm/Instructions.h:949:
llvm::ICmpInst::ICmpInst(llvm::CmpInst::Predicate, llvm::Value*,
llvm::Value*, const llvm::Twine&): Assertion
`(getOperand(0)->getType()->isIntOrIntVectorTy() ||
getOperand(0)->getType()->isPointerTy()) && "Invalid operand types for
ICmp instruction"' failed.
Aborted

I think that might be a generic sparse floating point issue but I
didn't look too closely.

                                Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
