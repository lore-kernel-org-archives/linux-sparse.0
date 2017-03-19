From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Cast to double being removed
Date: Sun, 19 Mar 2017 15:43:04 +0000
Message-ID: <CACXZuxcShqiQ=R7dixD8DD8zuxt9WqAsQf1kkZLAYgJPGhbfcg@mail.gmail.com>
References: <CACXZuxdNCM5wWvnYhvt65WaX6hSR_fTnaqd7=pv8O81NWoYQ_w@mail.gmail.com>
 <20170319152238.th3ts4pn7fcecpkt@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36792 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdCSPoK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 11:44:10 -0400
Received: by mail-it0-f46.google.com with SMTP id w124so66205575itb.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 08:43:05 -0700 (PDT)
In-Reply-To: <20170319152238.th3ts4pn7fcecpkt@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 19 March 2017 at 15:22, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Mar 17, 2017 at 12:00:00AM +0000, Dibyendu Majumdar wrote:
>> Hi,
>>
>> In this simple example:
>>
>> extern int printf(const char *, ...);
>> int main(void)
>> {
>>     printf("%f\n", (double)-1);
>>     return 0;
>> }
>>
>> The linearized output is:
>>
>> main:
>> .L0:
>>         <entry-point>
>>         symaddr.64  %r1 <- <anon symbol:000001BAAB487258>
>>         call.32     %r2 <- printf, %r1, $-1
>>         ret.32      $0
>>
>> The cast to double has been removed. I am trying to understand where
>> this is happening as it seems to happen quite early on. Any tips on
>> where I should look?
>
> This is fixed by the patch I sent two days ago:
>         https://patchwork.kernel.org/patch/9618765/
>

I found that in the simplification phase no account is taken of the
fact that a constant is floating point. Please try to run this test
and let me know if it works.

https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/netlib/paranoia.c

I had to switch off simplifications of instructions that have a
floating point type.

Regards
Dibyendu
