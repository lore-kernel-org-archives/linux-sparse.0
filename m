From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect handling of function pointers
Date: Fri, 10 Mar 2017 18:13:16 +0000
Message-ID: <CACXZuxe9ioYu5fuZK=-iDdiL8RQpE37GvpE9s5DHjFYPCrKKfg@mail.gmail.com>
References: <CACXZuxeHAXK11Tyx0PSg_uqDo0rZ3Cw+aZ5gN1S_LpPMZG8cCQ@mail.gmail.com>
 <20170310174445.4fmyibgvl7yyaz2s@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:34949 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbdCJSNS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Mar 2017 13:13:18 -0500
Received: by mail-it0-f53.google.com with SMTP id m27so1095090iti.0
        for <linux-sparse@vger.kernel.org>; Fri, 10 Mar 2017 10:13:17 -0800 (PST)
In-Reply-To: <20170310174445.4fmyibgvl7yyaz2s@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 10 March 2017 at 17:44, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Mar 10, 2017 at 02:23:26PM +0000, Dibyendu Majumdar wrote:
>> Hi,
>>
>> This example fails:
>>
>> extern int (*f) (int);
>> int main(int argc, const char *argv[]) {
>>  if (f) {
>>   return (*f)(6);
>>  }
>> }
>>
>> The linearized output is:
>>
>> main:
>> .L0:
>>         <entry-point>
>>         load.64     %r1(f) <- 0[f]
>>         br          %r1(f), .L1, .L3
>> .L1:
>>         load        %r3 <- 0[%r1(f)]
>>         call.32     %r4 <- %r3, $6
>>         br          .L3
>> .L3:
>>         ret.32      %r4
>>
>> It is the second load that is failing. Am investigating the cause - it
>> seems something to do with calc_memop_addr().
>
> No, it's a problem with the linearized code.
> There is no reasons for this second load to even exist.
> You can see this by replacing '(*f)(6)' by the equivalent 'f(6)'.

Okay.

>
> Also you should be careful with this example as there is no
> return for the 'else' part which create some undefined value
> which can create weirdness.
>

Yes, here is an amended test.

static int testfunc(int i) {
 return i-6;
}
static int (*f) (int) = testfunc;
int main(int argc, const char *argv[]) {
 if (f) {
  return f(6);
 }
 else {
  return 1;
 }
}

I am creating a bunch of tests that can be run after compiling. The
current backend tests are not very useful as they do not actually run
or validate the results.

Regards
Dibyendu
