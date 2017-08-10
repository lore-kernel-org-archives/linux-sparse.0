From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-llvm test cases
Date: Thu, 10 Aug 2017 14:38:54 -0400
Message-ID: <CANeU7Q=zF9hRqnNCN-+p0Y64yfkyaBvroeSP7faM4DSWW2RW5g@mail.gmail.com>
References: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35488 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbdHJSiz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 14:38:55 -0400
Received: by mail-yw0-f174.google.com with SMTP id l82so9951945ywc.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 11:38:55 -0700 (PDT)
In-Reply-To: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 12, 2017 at 9:13 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:

>
> https://github.com/dibyendumajumdar/dmr_c/tree/master/tests
>
I take a brief look. I think it has way to many duplicate copy of the
testrun.sh. You might want to think coherently what exactly is need
for your different test case. It is better to have one frame work to
support all the test case.

Another question is that, I don't know how many your test get impact
by the llvm versions. If it get tight to a specific version of llvm, the
test case has less value. People will get false positives due to different
llvm version.

Chris
