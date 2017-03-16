From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential linearizer over simplication
Date: Thu, 16 Mar 2017 11:27:55 +0000
Message-ID: <CACXZuxeuDyGC9Tm0BCiunJcXpETbn_g8w1HPwFq1h9CRFAsbDg@mail.gmail.com>
References: <CACXZuxcf6TX8=9Cn=oa7-i_ok3KSeDUeyGg3ssdswjUFK=ADbg@mail.gmail.com>
 <CACXZuxczRiSSRu1V4v82P1u+VbwRF7-DXUkDq3WXU+9S=MSvjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37863 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdCPL2b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 07:28:31 -0400
Received: by mail-it0-f54.google.com with SMTP id g138so38823972itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 04:27:56 -0700 (PDT)
In-Reply-To: <CACXZuxczRiSSRu1V4v82P1u+VbwRF7-DXUkDq3WXU+9S=MSvjA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

On 16 March 2017 at 11:16, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 15 March 2017 at 00:00, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> I am investigating a test that is failing. I noticed that the
>> linearized output for:
>>
>> static double cbrtl (double x)
>> {
>>     int hx;
>>     double r,s,w;
>>     double lt;
>>     unsigned sign;
>>     union {
>>  double t;
>>  unsigned pt[2];
>>     } ut, ux;
>>     int n0;
>>     ut.t = 1.0;
>>     n0 = (ut.pt[0] == 0);
>>     ut.t = 0.0;
>>     ux.t = x;
>>
>> is this:
>>
>> cbrtl:
>> .L0:
>>  <entry-point>
>>  load.32     %r2 <- 0[ut]
>>  seteq.32    %r3 <- %r2, $0
>>  set.64      %r4 <- 0.000000
>>  store.64    %r4 -> 0[ut]
>>  store.64    %arg1 -> 0[ux]
>>
>> The assignment of 1.0 to ut.t has been skipped. Does this look
>> correct? Is there a way to switch off optimisation / simplification?
>>
>
> Hi , investigating this further it seems that the problem is in
> kill_dominated_stores(). The original sequence is:
>
>         set.64      %r1 <- 1.000000
>         store.64    %r1 -> 0[ut]
>         load.32     %r2 <- 0[ut]
>         seteq.32    %r3 <- %r2, $0
>         store.32    %r3 -> 0[n0]
>         set.64      %r4 <- 0.000000
>         store.64    %r4 -> 0[ut]
>
> As there is a load of 32 from 0[ut] and that value is then stored
> somewhere else, the first store.64 instruction should mot be killed,
> but this is being killed in the above mentioned function. I do not
> understand the code enough to suggest a fix unfortunately.
>

It seems that the fix might for dominates() to return -1 when it sees
loads and stores of different size rather than 0 as it does now.
Certainly this appears to fix this particular test case:

 if (!same_memop(insn, dom)) {
  if (dom->opcode == OP_LOAD)
   return -1; /* instead of 0 */
  if (!overlapping_memop(C, insn, dom))
   return 0;
  return -1;
 }
