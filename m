From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect definition of local variables
Date: Tue, 7 Mar 2017 07:31:34 +0000
Message-ID: <CACXZuxcC-VPjB9CD0E9zUXp6XNS8v1DdvPUZ1vc88jqwYdFUhA@mail.gmail.com>
References: <CACXZuxdH3tryp92DVHhd8zs9bUTbrAs92Pz+knnDqDzj4eXWYQ@mail.gmail.com>
 <20170307064436.qtcscbwbjsrjoyko@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:35346 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdCGHl7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 02:41:59 -0500
Received: by mail-io0-f169.google.com with SMTP id z13so86092071iof.2
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 23:40:06 -0800 (PST)
In-Reply-To: <20170307064436.qtcscbwbjsrjoyko@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 7 March 2017 at 06:44, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Mar 07, 2017 at 12:08:22AM +0000, Dibyendu Majumdar wrote:
>> When I try to compile following in sparse-llvm:
>>
>> int main(const char *argv[]) {
>>  int values[5];
>>  values[0] = 9;
>>  ...
>>  values[4] = 5;
>>  int *p = &values[4];
>>  return (*p == 5) ? 0 : 1;
>> }
>>
>> I get:
>>
>> @values = external global [5 x i32]
>> ...
>>
>> Here 'values' has been defined above as external global, whereas it
>> should be allocated on the stack.
>
> Mmmh, I'll need to look a bit further at this one.
>

It appears that sparse-llvm only creates a local stack object for each
OP_PHI instruction. What should be the general approach for
identifying local stack objects in sparse linearized output?

Regards
Dibyendu
