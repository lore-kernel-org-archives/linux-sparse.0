From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] check missing or duplicate goto labels
Date: Mon, 4 Jun 2012 19:22:18 -0400
Message-ID: <B037A82F-AA0F-4E2E-B9AF-C56E85D80D1D@gmail.com>
References: <1338753706-24520-1-git-send-email-xi.wang@gmail.com> <CANeU7QkToacKXoTUg60mbtvqoD0RzTHAUfp6zprD1BbZoiynxg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:60219 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab2FDXWW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jun 2012 19:22:22 -0400
Received: by gglu4 with SMTP id u4so3529951ggl.19
        for <linux-sparse@vger.kernel.org>; Mon, 04 Jun 2012 16:22:22 -0700 (PDT)
In-Reply-To: <CANeU7QkToacKXoTUg60mbtvqoD0RzTHAUfp6zprD1BbZoiynxg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Jun 4, 2012, at 7:10 PM, Christopher Li wrote:

> On Sun, Jun 3, 2012 at 1:01 PM, Xi Wang <xi.wang@gmail.com> wrote:
>> This patch sets ->stmt of a SYM_LABEL to the corresponding label
>> statement.  If ->stmt was already set, it is a duplicate label.
>> 
>> On the other hand, if ->stmt of a goto label is not set during
>> evaluation, the label was never declared.
> 
> Looks great! Can you please send me a signed off line?

Oh sorry how did I miss that..

Signed-off-by: Xi Wang <xi.wang@gmail.com>
