From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH 4/4] Have Makefile import config.mak if it exists.
Date: Tue, 2 Jun 2009 20:37:04 -0400
Message-ID: <db65a1cd0906021737p66cd5abcs87600f73b7792809@mail.gmail.com>
References: <1243881445-30069-1-git-send-email-naesten@gmail.com>
	 <1243881445-30069-2-git-send-email-naesten@gmail.com>
	 <1243881445-30069-3-git-send-email-naesten@gmail.com>
	 <1243881445-30069-4-git-send-email-naesten@gmail.com>
	 <70318cbf0906021330n7d0df47y5010dd158f731966@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:6262 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbZFCAhD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 2 Jun 2009 20:37:03 -0400
Received: by yw-out-2324.google.com with SMTP id 5so4906642ywb.1
        for <linux-sparse@vger.kernel.org>; Tue, 02 Jun 2009 17:37:04 -0700 (PDT)
In-Reply-To: <70318cbf0906021330n7d0df47y5010dd158f731966@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Jun 2, 2009 at 4:30 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Jun 1, 2009 at 11:37 AM, Samuel Bronson <naesten@gmail.com> wrote:
>> This will allow users to override build settings without dirtying their
>> trees, making life with `git stash' a bit easier.
>>
> I modify the patch to use "local.mk" and add it in .gitignore.
>
> If that works for you, I am going to apply it as yours.

Yeah, that's fine.
