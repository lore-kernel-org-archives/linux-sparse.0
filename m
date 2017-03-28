From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential incorrect simplification
Date: Tue, 28 Mar 2017 14:58:57 +0100
Message-ID: <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:38663 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbdC1N7h (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 09:59:37 -0400
Received: by mail-it0-f50.google.com with SMTP id y18so19564917itc.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 06:59:22 -0700 (PDT)
In-Reply-To: <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 28 March 2017 at 14:34, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Mar 28, 2017 at 2:40 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> I am getting a failure in following test when simplifications are enabled:
>>
>> extern int printf(const char *, ...);
>>
>> int main(void)
>> {
>>    struct{
>>      int twobit:2;
>>      int       :1;
>>      int threebit:3;
>>      unsigned int onebit:1;
>>    } s3;
>>
>>    s3.onebit = 1;
>>    if(s3.onebit != 1){
>>       printf("Be especially careful with 1-bit fields! %d\n", (int) s3.onebit);
>>       return 1;
>>    }
>>    return 0;
>> }
>>
>> The output (truncated) from linearizer without simplications is this:
>>
>> main:
>> .L0:
>>         <entry-point>
>>         load.32     %r1 <- 0[s3]
>>         shl.32      %r2 <- $1, $6
>>         and.32      %r3 <- %r1, $-65
>>         or.32       %r4 <- %r3, %r2
>>         store.32    %r4 -> 0[s3]
>>         load.32     %r5 <- 0[s3]
>>         lsr.32      %r6 <- %r5, $6
>>         cast.32     %r7 <- (1) %r6
>>         setne.32    %r8 <- %r7, $1
>>         br          %r8, .L1, .L2
>>
>> But if simplifications are on then we get:
>>
>> main:
>> .L0:
>>         <entry-point>
>>         and.32      %r3 <- %r4, $-65
>>         or.32       %r4 <- %r3, $64
>>         lsr.32      %r6 <- %r4, $6
>>         cast.32     %r7 <- (1) %r6
>>         setne.32    %r8 <- %r7, $1
>>         br          %r8, .L1, .L3
>
> Are you worried about the load of s3 (wich is not initialized)?
> Or the store of s3 (wich is local and never used but for .onebit)?
> Or the size of %r6 (which is created as 32bit but used as 1bit)?
>
> If the later, you're missing the patch
>     https://git.kernel.org/pub/scm/devel/sparse/sparse.git/commit/?h=sparse-next&id=522773d089700cce5551860aea3cb93f40b5f3a4
>


The first instruction and.32 refers to %r4 which is undefined.

Regards
Dibyendu
