From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm outstanding fixes
Date: Sun, 26 Mar 2017 23:14:36 +0100
Message-ID: <CACXZuxdkuRyvpBt1eLur77orjFd74+2vqCE54UsAzqR+P=8LfQ@mail.gmail.com>
References: <CACXZuxeKgVsaz_7TKseghcxzxZNdvK0gU-MhLxtmzYye8Uwz_g@mail.gmail.com>
 <CACXZuxfDudaFj7Qybtrfw0JRWr9n5ofMA7XHB5Sh+EWfU4EEDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:34212 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdCZWPZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Mar 2017 18:15:25 -0400
Received: by mail-it0-f50.google.com with SMTP id y18so14876348itc.1
        for <linux-sparse@vger.kernel.org>; Sun, 26 Mar 2017 15:14:36 -0700 (PDT)
In-Reply-To: <CACXZuxfDudaFj7Qybtrfw0JRWr9n5ofMA7XHB5Sh+EWfU4EEDw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

Hi,

I have been reviewing and have selectively merged changes from the
latest v5 LLVM fix series. There are still some issues that are
outstanding:

On 13 March 2017 at 19:04, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>> This is just a summary of the fixes that are not yet in any patch series:
>>
>> + Incorrect generation of GEP offsets due to offset being unsigned.
>> + Support for local variables is missing (local variables get declared as global)
> + function ptr call syntax of the type (*f)() results in wrong linearized output.

+ Initialization of local objects must zero out the object before
executing instructions to initialize.
+ The simplification of instructions that are of type floating should
be disabled to ensure correct output.
+ The simplification phase generates incorrect code when a variable is
initialized in a branch and the usage is such that variable is
initialized prior to use.
+ The handling of floats is not yet complete in sparse-llvm

I am not able to test the published version of sparse-llvm as it is
missing some of the fixes  are not present.

Thanks and Regards
Dibyendu
