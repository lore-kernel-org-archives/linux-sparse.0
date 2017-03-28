From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm array size computation issue
Date: Tue, 28 Mar 2017 22:49:15 +0200
Message-ID: <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35881 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdC1Ut2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 16:49:28 -0400
Received: by mail-qk0-f177.google.com with SMTP id p22so76769710qka.3
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 13:49:22 -0700 (PDT)
In-Reply-To: <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 10:41 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> On 28 March 2017 at 21:25, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> I am investigating an issue with following test case:
>>
>> int main(void)
>> {
>> const char *names[] = {
>> "dibyendu",
>> "majumdar",
>> NULL,
>> };
>> return 0;
>> }
>>
>> The issue here is that sparse-llvm thinks the array size is zero:
>>
>> define i32 @main() {
>> L0:
>>   %names_0000026DE9D2DDA8. = alloca [0 x i8*]
>>
>> It appears that sparse is correctly calculating the size of the array
>> in examine_node_type() in symbol.c, but by the time the symbol gets to
>> sparse-llvm the bit_size is somehow changed to -1. I haven't yet
>> tracked down where this is happening.
>>
>
> Looks like the computed bit_size is being held on the SYM_NODE but
> sparse-llvm looks as the bit_size field in the SYM_ARRAY node. Does
> this sound like a problem - i.e. somehow the SYM_ARRAY is not getting
> its size set?

What happening if you change to : return sizeof(names); ?

-- Luc
