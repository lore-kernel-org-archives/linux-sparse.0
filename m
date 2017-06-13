From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Subject: ./include/linux/err.h:35:16: warning: dereference of noderef expression
Date: Tue, 13 Jun 2017 11:55:26 +0200
Message-ID: <CAFGhKby4e5fLwr=0xj9by_UiX2u7eVYJZz5gNaAjYKDRrUDB3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36069 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdFMJz1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 05:55:27 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@primarydata.com>, Dan Carpenter <dan.carpenter@oracle.com>

Hi,

I have following code which generates a warning when compiling with "make C=1".

~~~~~~~
struct task_struct *kthread;
kthread = kthread_create(xxxxx, yyyyy, "zzzzz");
if (IS_ERR(kthread)) {
~~~~~~~

The warning is

    ./include/linux/err.h:35:16: warning: dereference of noderef expression

And disappears when I remove the IS_ERR. How do I correctly work
around this incorrect warning?

Btw. I am using Debian stretch amd64. It seems like this is related to
the __force used in the parameter list of IS_ERR. Removing it also
removes the warning.

If it is fixed in sparse's git then when will there be a new release of it?

Greetings,
Charlemagne Lasse
