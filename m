From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Potential problem with variable handling - Was: Handling of local
 variables in the backend
Date: Wed, 13 Sep 2017 12:37:04 +0100
Message-ID: <CACXZuxfTMQVZqkL4kJr6pAo0wfUC-PA+P1WPLS9b9jGsEd1Yew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34226 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdIMLhF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Sep 2017 07:37:05 -0400
Received: by mail-vk0-f45.google.com with SMTP id o22so15745774vke.1
        for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2017 04:37:05 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

On 12 September 2017 at 22:54, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> One issue I am facing at the moment is that there is no explicit
> alloca for each symbol that is used in a function - so that the
> backend has to detect when a symbol is accessed and then do alloca to
> associate stack space. In the LLVM backend this is not so much an
> issue as LLVM allows instructions to be inserted at a particular point
> - so my code just ensures that all the allocas go at the start of the
> function as required by LLVM. But I am having trouble with the other
> backend that doesn't have this capability.
>

I have been thinking about this issue for some time - i.e. that the
Sparse IR does not explicitly define or initialize local variables.
The back-end deals with it by doing it at first access. But this could
result in incorrect behavior if the initialization was meant to occur
at a certain point in the code. I should probably try to prove this
theory by creating a test - but intuitively it seems that if the
programmer had meant to initialize a variable at a particular point,
there could be a reason why it should be done at that point and not
some point later.

Regards
Dibyendu
