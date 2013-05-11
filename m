From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix SIGFPE caused by signed division overflow
Date: Sat, 11 May 2013 11:25:26 -0700
Message-ID: <518E8D16.7040008@chrisli.org>
References: <1368219635-4524-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62187 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab3EKSZd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 May 2013 14:25:33 -0400
Received: by mail-pa0-f51.google.com with SMTP id ld10so3648754pab.38
        for <linux-sparse@vger.kernel.org>; Sat, 11 May 2013 11:25:33 -0700 (PDT)
In-Reply-To: <1368219635-4524-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org

On 05/10/2013 02:00 PM, Xi Wang wrote:
> Avoid evaluating INT_MIN / -1 and INT_MIN % -1, which will trap on x86
> and crash sparse.

Applied.

Chris
