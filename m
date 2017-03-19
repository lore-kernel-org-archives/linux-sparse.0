From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 00/30] LLVM fixes
Date: Sun, 19 Mar 2017 18:41:40 +0000
Message-ID: <CACXZuxe2hiPBPYpSgxQ73fQ=JZ=4_a3SziLHxoHG68=TBEeXKw@mail.gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com> <CACXZuxfxqcVqf=LHNNpQgvtB7c==qz_fr_+ddvhGfW06azGUdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:33348 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbdCSSvG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 14:51:06 -0400
Received: by mail-it0-f50.google.com with SMTP id w124so23149546itb.0
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 11:50:26 -0700 (PDT)
In-Reply-To: <CACXZuxfxqcVqf=LHNNpQgvtB7c==qz_fr_+ddvhGfW06azGUdA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

Hi Luc,

On 19 March 2017 at 16:09, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 19 March 2017 at 01:41, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> This series solves a number of issues in sparse-llvm,
>> mainly about wrong or missing type information as needed
>> to build LLVM IR.
>> Most of these issues have been reported and investigated by
>> Dibyendu Majumdar.
>>
>> Changes since v2:
>> - remove the changes tha gave a type to PSEUDO_VALs
>> - introduction of OP_PUSH instructions
>> - move toward generic solution using the instruction's type
>> - some more fixes
>> - temporary remove changes related to OP_SYMADDR
>>
>> * patches 1 & 2 are fixes/improvement of inlined call
>>           unrelated to LLVM
>> * patch   3 add support of OP_PUSH and solve variadic + constant
>> * patches 4 & 5 add missing type to some instructions
>> * patches 6-14 are preparatory cleanups
>> * patch   15 fix a problme with floats & SYM_NODE
>> * patch   16 improve the typing of contants
>> * patches 17 & 18 are fixes
>> * patch   19 fix issues with degenerated pointers
>> * patches 20-23 add test cases solved by patch 19
>> * patches 24-30 are fixes
>>
>> These patches already allow to compile a lot more code to LLVM
>> but there is still known issues with sparse-llvm:
>> - it won't work on bitfields
>> - it won't work on computed gotos
>> - it won't work on label-as-value
>> - it won't work on exotic instructions (OP_SPLICE)
>> - there is a bunch of problems with floats
>>   (but this is not specific to sparse-llvm).
>> There is most probably a bunch of others issues too.
>>
>> For convenience, this serie is also available at:
>>   https://github.com/lucvoo/sparse/tree/llvm-fixes-v3
>>
>>
>> Luc Van Oostenryck (30):
>>   fix usage of inlined calls
>>   inlined calls should not block BB packing
>>   give function's arguments a type via OP_PUSH
>>   give a type to OP_PHISOURCE
>>   give a type to OP_SEL, always
>>   llvm: remove unneeded arg 'module'
>>   llvm: remove unneeded 'generation'
>>   llvm: remove unneeded function::type
>>   llvm: reduce scope of 'bb_nr'
>>   llvm: use pseudo_list_size() instead of open coding it
>>   llvm: give arguments a name
>>   llvm: give a name to call's return values
>>   llvm: avoid useless temp variable
>>   llvm: extract get_sym_value() from pseudo_to_value()
>>   llvm: fix test of floating-point type
>>   llvm: fix translation of PSEUDO_VALs into a ValueRefs
>>   llvm: fix output_op_store() which modify its operand
>>   llvm: fix output_op_[ptr]cast()
>>   llvm: take care of degenerated rvalues
>>   llvm: add test cases for symbol's address
>>   llvm: add test cases for pointers passed as argument
>>   llvm: add test cases for arrays passed as argument
>>   llvm: add test cases for degenerated pointers
>>   llvm: add support for OP_NEG
>>   llvm: fix pointer/float mixup in comparisons
>>   llvm: fix type in comparison with an address constant
>>   llvm: give correct type to binops
>>   llvm: adjust OP_RET's type
>>   llvm: variadic functions are not being marked as such
>>   llvm: fix type of switch constants
>>
>
> Thank you for posting this series. I have applied the OP_PUSH changes
> to my repository and removed the previous solution of types on
> PSEUDO_VALs, and I am happy to report that it did not cause any new
> failures in my test cases. I haven't yet checked some of the other
> fixes above as I already had fixes for these, so I am not yet able to
> confirm whether these resolve the issues I faced. I will try them out
> over the next few days and report back.
>

I have successfully tested the binary ops changes, but the comparison
and rvalue changes appear to not cover all cases. I will see if I can
submit tests.

Thanks and Regards
Dibyendu
