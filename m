From: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: assertion failure in flow.c:804 (changed) building kernel/sched.c
Date: Mon, 03 Mar 2008 14:29:40 +0100
Message-ID: <47CBFD44.30404@tiscali.nl>
References: <47CBF7B8.5060303@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp-out2.tiscali.nl ([195.241.79.177]:40502 "EHLO
	smtp-out2.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYCCN3n (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 3 Mar 2008 08:29:43 -0500
Received: from [82.171.187.43] (helo=[192.168.1.2])
	by smtp-out2.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1JWAjd-0001G3-W0
	for <linux-sparse@vger.kernel.org>; Mon, 03 Mar 2008 14:29:42 +0100
In-Reply-To: <47CBF7B8.5060303@tiscali.nl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Roel Kluin wrote:
> Building the linux kernel (git, linus' tree) with sparse enabled I get the
> following assertion failure:

Never mind, It appears an ancient version of sparse was used rather than
the git-compiled version I recently built.
