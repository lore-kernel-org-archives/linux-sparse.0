From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Mon, 6 Mar 2017 15:32:05 +0000
Message-ID: <CACXZuxfX0TiYGJDewbRW9Tr3-nzqiBrdOK0K+mO0qqwyGCrjSQ@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-8-luc.vanoostenryck@gmail.com> <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33959 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754143AbdCFPdU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 10:33:20 -0500
Received: by mail-it0-f66.google.com with SMTP id r141so9917227ita.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 07:32:06 -0800 (PST)
In-Reply-To: <CANeU7Qk6xjhNPVZWxTB4iOavH5=bha+a_utz7+PJuSTo1WKgOg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 6 March 2017 at 15:16, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> In sparse, pointer arithmetic and accessing the field
>> of a structure or an array is simply done via OP_ADD,
>> the offset being calculated at evaluation time.
>> On the other hand, LLVM allows addition only on two
>> integers and pointer arithmetic/member access is done
>> via 'getelementptr'.
>>
>> sparse-llvm didn't took this in account which resulted
>> in type error in 'add' instructions.
>>
>> Fix this by catching addition involving pointer and issuing
>> a getelementptr' instruction for these.
>
> I have one related question. In the case of anonymous
> structure or union, how to you figure out which series of
> GEP it needs to be? I think sparse already lost the element
> pointer index information. You can construct it back by looking
> at the bit offset. But if there is union then the element point can
> have multiple path to reach to the same bit offset. I don't
> know how to deal with that.

Sparse-llvm appears to bypass the normal struct GEP in LLVM. It
basically casts everything to char *, uses GEP to obtain a pointer to
member, and then casts it back to member type. So this should work for
structs and unions.

>
>>
>> Originally-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>  sparse-llvm.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/sparse-llvm.c b/sparse-llvm.c
>> index 27cc1b88c..ee374b217 100644
>> --- a/sparse-llvm.c
>> +++ b/sparse-llvm.c
>> @@ -472,6 +472,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
>>         case OP_ADD:
>>                 if (symbol_is_fp_type(insn->type))
>>                         target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
>> +               else if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind)
>> +                       target = LLVMBuildGEP(fn->builder, lhs, &rhs, 1, "");
>> +               else if (LLVMGetTypeKind(LLVMTypeOf(rhs)) == LLVMPointerTypeKind)
>> +                       target = LLVMBuildGEP(fn->builder, rhs, &lhs, 1, "");
>
> It seems that you only have one level of indices. Also the OP_ADD use the member
> offset of the struct. I am not sure how it map into GEP indices.
> Correct me if I am
> wrong, it seems to me you use the member offset as element indices. I
> think it need
> to get a mapping between offset to indices.
>

This case is more about handing pointer arithmetic correctly. Here GEP
is being used as array element access and not for struct member
access.

Hope this is helpful.

Regards
Dibyendu
