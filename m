From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Understanding how sparse handles multiple input files
Date: Fri, 16 Jun 2017 00:14:42 +0100
Message-ID: <CACXZuxcb-GFjCUWLKVO9L0CBejVZ9huYCa7aD+GAMHBnwE0THw@mail.gmail.com>
References: <CACXZuxfoXKWgxxHL7hkkp=FvU5917dZ7_A4Zd=ts9j37ZG5ikw@mail.gmail.com>
 <20170615040937.dzeiuvt5ixyv5qtq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34265 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdFOXOo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 19:14:44 -0400
Received: by mail-wm0-f50.google.com with SMTP id d64so184531wmf.1
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jun 2017 16:14:43 -0700 (PDT)
In-Reply-To: <20170615040937.dzeiuvt5ixyv5qtq@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 15 June 2017 at 05:09, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Jun 14, 2017 at 10:25:59PM +0100, Dibyendu Majumdar wrote:
>> I am trying to understand what happens when multiple input files are
>> given to sparse. Are the symbols from previous files dropped when
>> sparse moves on to the next file?
>>
>> I see a call to remove_symbol_scope() in end_scope() implying that
>> symbols are dropped - but then I am not sure I am understanding this
>> correctly.
>
> sparse seems to process the files more as if being concatenated
> (even if the file scope is respected)
> Is it something like this you're seeing with multiple input files?

I am interesting in using the results of the parsing phase - so just
to trying to understand the behaviour, so that I can work out the best
way to make use of the output.

Regards
Dibyendu
