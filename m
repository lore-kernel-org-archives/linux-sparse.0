From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Wed, 8 Mar 2017 23:38:22 +0000
Message-ID: <CACXZuxcbDJAeRBN_wpTRPRk7efOM2vLytke=k_0f4=C0dOQtrA@mail.gmail.com>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
 <20170307064436.qtcscbwbjsrjoyko@macpro.local> <CACXZuxcC-VPjB9CD0E9zUXp6XNS8v1DdvPUZ1vc88jqwYdFUhA@mail.gmail.com>
 <20170308065337.vwrebdlo4poc4da4@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35840 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbdCHXjE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Mar 2017 18:39:04 -0500
Received: by mail-it0-f44.google.com with SMTP id h10so119141418ith.1
        for <linux-sparse@vger.kernel.org>; Wed, 08 Mar 2017 15:38:23 -0800 (PST)
In-Reply-To: <20170308065337.vwrebdlo4poc4da4@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 8 March 2017 at 06:53, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Mar 07, 2017 at 07:31:34AM +0000, Dibyendu Majumdar wrote:
>> >> Here 'values' has been defined above as external global, whereas it
>> >> should be allocated on the stack.
>> >
>> > Mmmh, I'll need to look a bit further at this one.
>> >
>>
>> It appears that sparse-llvm only creates a local stack object for each
>> OP_PHI instruction. What should be the general approach for
>> identifying local stack objects in sparse linearized output?
>
> I've looked a bit at this and there is several issues at hand.
> It's also not something LLVM specific.
> So I can't answer to this for now. Hopefully, I'll be able to tell
> you more in a few days.
>

Thank you for looking into this. It would be good to know what issues
you have discovered. I was wondering if a simple solution is to check
whether the symbol is marked  as toplevel / extern - and if not then
define it as a local symbol in LLVM. However we would need to handle
scope - i.e. if the same symbol occurs multiple times in a function in
different scopes then these need to be defined accordingly. Example:

extern void init(int *v);
int main(const char *argv[]) {
 int n = 0;
 {
  int x[5];
  init(x);
  n += x[0];
 }
 {
  int x[6];
  init(x);
  n += x[0];
 }
 return n;
}

Regards
Dibyendu
