From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 0/3] Adding selfcheck target
Date: Sun, 16 Jul 2017 21:55:38 -0400
Message-ID: <CANeU7QmP5Ezy6cbmMZOFsRk8FN+8JDzL9BU5hJ8dLoaWmCNR=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35117 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdGQBzk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 16 Jul 2017 21:55:40 -0400
Received: by mail-pf0-f175.google.com with SMTP id e199so7876164pfh.2
        for <linux-sparse@vger.kernel.org>; Sun, 16 Jul 2017 18:55:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Because we reserve a little bit more time on the 0.5.1-rc5 release,
I want to sneak in make selfcheck target for sparse. It should be
very low risk. The _Pragma() macro should have some impact
for sparse use in the field.

I am using the selfcheck for ptrlist refcount patch now. It is so
much better. I should have use it from the very beginning.
It immediately report about 20 refcount related context imbalance.
None of those are false alarm. I am not going to push the refcount
patch to RC5. This is series is what I consider low risk and useful
for RC5.

Chris
