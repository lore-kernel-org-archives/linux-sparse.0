Return-Path: <SRS0=dH8I=BW=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950B6C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 12 Aug 2020 01:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C71C206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 12 Aug 2020 01:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHLBHG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:07:06 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:52309 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgHLBHG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Aug 2020 21:07:06 -0400
Received: by mail-il1-f198.google.com with SMTP id z14so611881ilk.19
        for <linux-sparse@vger.kernel.org>; Tue, 11 Aug 2020 18:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=X3NiX6nVSgp11EpijWT3pX7H1MOgqhCnBt3mOeEwKPI=;
        b=ZMUeIV27FJ7cOfImKb/vj1BBHL6Oa2pdctiWSnrpLimhMKQinIwwmlUN3WE1bTDnjr
         RtjpUPcQK6/p2VHrLlpmozGtyiPZxlmjW42i8s8B5FYFSRmDyLQSANLmpz7IBajNY0Xq
         tSncdZyp7ZEHyi4IMFGlfNyzswQjhl+yWAa7nCC2oMNINkABNDWDYE7O49GXpmVdOWLg
         B/IGoZhV7kbdt43+QhUzUSYri0IwUcQ/tc748Vj2tarDjU0rCxRmBl2aPLi7XIU/ti9W
         XRdHOqiwvK6HNvsIlUCKLp53cvY3Vxb8tZKvCb6P4rfNBbuaV7XcE6i1/KVWCqTTXi17
         2c3Q==
X-Gm-Message-State: AOAM533BU7gmBc2tkDmzu3bLsNHwDVb0ociJFn0mwZaISzikBka860FB
        yoxevbNRb6o2Yokm9/Tmq+1evgHxXMTe/8jE/AiBPbsWYaOZ
X-Google-Smtp-Source: ABdhPJzflhizS6nniBWRSpW8mHijAZdmSAeiEp/VNDrTlrQJdIKYs08rqIEDvlb4OOzwu63y0W80MTCFDtmUkUL4JXTKE6e0ZT1S
MIME-Version: 1.0
X-Received: by 2002:a92:bbc6:: with SMTP id x67mr26231257ilk.235.1597194425363;
 Tue, 11 Aug 2020 18:07:05 -0700 (PDT)
Date:   Tue, 11 Aug 2020 18:07:05 -0700
In-Reply-To: <000000000000b6b450059870d703@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c72d405aca3ce17@google.com>
Subject: Re: KASAN: global-out-of-bounds Read in precalculate_color
From:   syzbot <syzbot+02d9172bf4c43104cd70@syzkaller.appspotmail.com>
To:     a.darwish@linutronix.de, akpm@linux-foundation.org,
        bsegall@google.com, changbin.du@intel.com,
        clang-built-linux@googlegroups.com, davem@davemloft.net,
        dietmar.eggemann@arm.com, dvyukov@google.com, elver@google.com,
        ericvh@gmail.com, hverkuil-cisco@xs4all.nl, jpa@git.mail.kapsi.fi,
        juri.lelli@redhat.com, kasan-dev@googlegroups.com,
        keescook@chromium.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sparse@vger.kernel.org, luc.vanoostenryck@gmail.com,
        lucho@ionkov.net, mark.rutland@arm.com, masahiroy@kernel.org,
        mchehab@kernel.org, mgorman@suse.de, mhiramat@kernel.org,
        michal.lkml@markovi.net, miguel.ojeda.sandonis@gmail.com,
        mingo@redhat.com, netdev@vger.kernel.org, paulmck@kernel.org,
        peterz@infradead.org, rminnich@sandia.gov, rostedt@goodmis.org,
        rppt@kernel.org, samitolvanen@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        v9fs-developer@lists.sourceforge.net, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, vivek.kasireddy@intel.com,
        will@kernel.org, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit dfd402a4c4baae42398ce9180ff424d589b8bffc
Author: Marco Elver <elver@google.com>
Date:   Thu Nov 14 18:02:54 2019 +0000

    kcsan: Add Kernel Concurrency Sanitizer infrastructure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eb65d6900000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=02d9172bf4c43104cd70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147e5ac1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b49e71e00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: kcsan: Add Kernel Concurrency Sanitizer infrastructure

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
