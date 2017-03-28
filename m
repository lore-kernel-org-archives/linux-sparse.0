From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm array size computation issue
Date: Tue, 28 Mar 2017 22:06:17 +0100
Message-ID: <CACXZuxcnxYvqM8=kDe=AkWuYB=TmU9mwd9gKc9_veZhbD0z1Xw@mail.gmail.com>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com> <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:36374 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdC1VGT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 17:06:19 -0400
Received: by mail-it0-f54.google.com with SMTP id e75so70773026itd.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 14:06:18 -0700 (PDT)
In-Reply-To: <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 28 March 2017 at 21:49, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Mar 28, 2017 at 10:41 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> On 28 March 2017 at 21:25, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>>> I am investigating an issue with following test case:
>>>
>>> int main(void)
>>> {
>>> const char *names[] = {
>>> "dibyendu",
>>> "majumdar",
>>> NULL,
>>> };
>>> return 0;
>>> }
>>>
>>> The issue here is that sparse-llvm thinks the array size is zero:
>>>
>>> define i32 @main() {
>>> L0:
>>>   %names_0000026DE9D2DDA8. = alloca [0 x i8*]
>>>
>>> It appears that sparse is correctly calculating the size of the array
>>> in examine_node_type() in symbol.c, but by the time the symbol gets to
>>> sparse-llvm the bit_size is somehow changed to -1. I haven't yet
>>> tracked down where this is happening.
>>>
>>
>> Looks like the computed bit_size is being held on the SYM_NODE but
>> sparse-llvm looks as the bit_size field in the SYM_ARRAY node. Does
>> this sound like a problem - i.e. somehow the SYM_ARRAY is not getting
>> its size set?
>
> What happening if you change to : return sizeof(names); ?
>

sizeof works okay.
