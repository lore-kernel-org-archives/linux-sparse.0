From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [RFC/PATCH] sparse, llvm: Fix string globals access
Date: Sat, 9 Jun 2012 14:00:38 +0300
Message-ID: <CAOJsxLFX-ZiDCQ84uKka4MYa_uUhLMPeR=XWAHMevTRFsfZBJA@mail.gmail.com>
References: <1339160327-8534-1-git-send-email-penberg@kernel.org>
	<4FD240E2.6040003@garzik.org>
	<CAOJsxLH9N84YwLrHQXn+R1r4cOd7DUuM2SpFq828mSV6WmHjqg@mail.gmail.com>
	<35CC6868-F462-4116-A143-81959DA38D5C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61842 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab2FILAj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2012 07:00:39 -0400
Received: by obbtb18 with SMTP id tb18so3751636obb.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jun 2012 04:00:38 -0700 (PDT)
In-Reply-To: <35CC6868-F462-4116-A143-81959DA38D5C@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jun 9, 2012 at 2:55 AM, Xi Wang <xi.wang@gmail.com> wrote:
> On Jun 8, 2012, at 4:39 PM, Pekka Enberg wrote:
>>
>> Xi, so I guess your current work on linearize.c might fix the SIGSEG=
V
>> I'm seeing?
>
> I guess the problem is that sparse-llvm generates an incorrect type
> `load i64*' in llvm from the sparse instruction load.64.
>
> =A0 =A0 =A0 =A0load.64 =A0 =A0 %r2 <- 0[foo]
> =A0 =A0 =A0 =A0call.32 =A0 =A0 %r1 <- puts, %r2
> =A0 =A0 =A0 =A0ret.32 =A0 =A0 =A0$0
>
> With the new ->ctype in pseudo sparse-llvm should be able to generate
> the correct type. =A0I am playing with an LLVM backend with typed pse=
udos;
> it generates the following code, which seems okay.
>
> @0 =3D internal global [7 x i8] c"Foo !\0A\00", align 1
> @foo =3D internal global i8* getelementptr inbounds ([7 x i8]* @0, i6=
4 0, i64 0), align 8
>
> define i32 @main(i32 %argc, i8** %argv) {
> entry:
> =A0%0 =3D load i8** @foo
> =A0%1 =3D call i32 @puts(i8* %0)
> =A0ret i32 0
> }

Right. Looking at your "splay" backend

static value_t emit_gep(builder_t builder, struct pseudo *src,
unsigned int offset, struct pseudo *dst)
{
	type_t charp =3D LLVMPointerType(LLVMInt8Type(), 0);
	value_t base =3D LLVMBuildPointerCast(builder, emit_pseudo(src), charp=
, "");
	value_t idx =3D LLVMConstInt(LLVMIntType(bits_in_pointer), offset, 0);
	value_t gep =3D LLVMBuildGEP(builder, base, &idx, 1, "");
	type_t type =3D LLVMPointerType(emit_type(dst->ctype), 0);

	return LLVMBuildPointerCast(builder, gep, type, "");
}

after which OP_LOAD translation becomes as simple as

	case OP_LOAD:
		return LLVMBuildLoad(builder, emit_gep(builder, insn->src,
insn->offset, insn->target), "");

Jeff, I guess we should do this for output_load() and output_store()
in sparse-llvm.c as well?
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
