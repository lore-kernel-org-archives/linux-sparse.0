From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Support -Wall flag
Date: Tue, 05 Dec 2006 02:57:24 -0800
Message-ID: <45755094.9080905@freedesktop.org>
References: <20060801175008.11809.99999.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:54976 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759939AbWLEK52 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Dec 2006 05:57:28 -0500
In-Reply-To: <20060801175008.11809.99999.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

Pavel Roskin wrote:
> If -Wall is specified, enable all warnings except those explicitly
> disabled by -Wno-* switches.

Applied, and thanks!  Sorry this slipped through the cracks.

- Josh Triplett
