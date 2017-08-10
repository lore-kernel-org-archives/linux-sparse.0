From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm test cases
Date: Thu, 10 Aug 2017 21:44:19 +0100
Message-ID: <CACXZuxdvBVV+gDzWmFs=FA_s5Ric1djbF7mLNiea06SaSiqUOQ@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
 <CANeU7Q=zF9hRqnNCN-+p0Y64yfkyaBvroeSP7faM4DSWW2RW5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:37150 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbdHJUoU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 16:44:20 -0400
Received: by mail-vk0-f52.google.com with SMTP id r199so7119351vke.4
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 13:44:19 -0700 (PDT)
In-Reply-To: <CANeU7Q=zF9hRqnNCN-+p0Y64yfkyaBvroeSP7faM4DSWW2RW5g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 10 August 2017 at 19:38, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Mar 12, 2017 at 9:13 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> https://github.com/dibyendumajumdar/dmr_c/tree/master/tests
>>
> I take a brief look. I think it has way to many duplicate copy of the
> testrun.sh. You might want to think coherently what exactly is need
> for your different test case. It is better to have one frame work to
> support all the test case.

Yes, the current arrangement is a stop gap. As I develop both on
Windows and Linux, I need a portable solution so I cannot really use
shell scripts.

>
> Another question is that, I don't know how many your test get impact
> by the llvm versions. If it get tight to a specific version of llvm, the
> test case has less value. People will get false positives due to different
> llvm version.
>

The tests are all designed to be runnable - i.e. you can generate the
code and run it either with lli or by generating an executable - so
they are completely independent of LLVM version. But they do need all
the LLVM fixes that are still pending as without those fixes most
tests won't even compile. Nevertheless we can start incorporating
these tests gradually so that when the LLVM fixes are all in then we
will have a good set of tests.

I would prefer to add validation of the Sparse IR as well - at present
I record these but do not try to validate mainly as I think Sparse IR
output is still changing so we need to get to a stable point first.

Regards
Dibyendu
