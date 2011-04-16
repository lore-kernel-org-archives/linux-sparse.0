From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: Re: [PATCH] memops.c: fix load instruction simplification
Date: Sat, 16 Apr 2011 16:50:50 +0200
Message-ID: <4DA9ACCA.2090000@seznam.cz>
References: <4D9E37A4.8040902@seznam.cz> <4DA1CE6A.9000202@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep12.mx.upcmail.net ([62.179.121.32]:49242 "EHLO
	fep12.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab1DPOu4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Apr 2011 10:50:56 -0400
In-Reply-To: <4DA1CE6A.9000202@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Only adding that after applying this patch, the sum of warnings/errors
when checking linux-2.6.35.12 sources (defconfig, x86) is not influenced.

-- 
Jan
