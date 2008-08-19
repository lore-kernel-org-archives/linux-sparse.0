From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: context imbalance false positive sparse warnings
Date: Tue, 19 Aug 2008 15:26:09 -0700
Message-ID: <1219184769.17033.95.camel@brick>
References: <524f69650808191447o62a421c3n65f3938c9fc28dd7@mail.gmail.com>
	 <8cef9d540808191500n10fa910eo674c8b8f2dd5b612@mail.gmail.com>
	 <524f69650808191522r21fc4babqaf173c9df558afc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:51909 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYHSW0I (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Aug 2008 18:26:08 -0400
Received: by wr-out-0506.google.com with SMTP id 69so168192wri.5
        for <linux-sparse@vger.kernel.org>; Tue, 19 Aug 2008 15:26:07 -0700 (PDT)
In-Reply-To: <524f69650808191522r21fc4babqaf173c9df558afc1@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: Stalin Kenny <stalinlinux@gmail.com>, linux-sparse@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>

On Tue, 2008-08-19 at 17:22 -0500, Steve French wrote:
> On Tue, Aug 19, 2008 at 5:00 PM, Stalin Kenny <stalinlinux@gmail.com> wrote:
> >> Even the simplest use cases throw this error e.g. fs/super.c line 162-164:
> >>
> >> static void put_super(struct super_block *sb)
> >> {
> >>       spin_lock(&sb_lock);
> >>       __put_super(sb);
> >>       spin_unlock(&sb_lock);
> >> }
> >
> > What is the sparse error when you call this function ?
> CHECK   fs/super.c
> fs/super.c:164:2: warning: context imbalance in 'put_super': wrong count at exit
> fs/super.c:164:2:    context 'lock': wanted 0, got 1
> 
> 

Johannes Berg had a 9-patch series that improved this somewhat, but they had
some bugs in them (crashes).  But I've been running with them anyway as they
do improve cases like this significantly.

Harvey

