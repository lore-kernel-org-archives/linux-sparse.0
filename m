From: Matt <matt@use.net>
Subject: inline declaration and assignment
Date: Mon, 10 Nov 2008 22:24:00 -0800 (PST)
Message-ID: <Pine.NEB.4.64.0811102205210.20411@cesium.clock.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cesium.clock.org ([192.5.16.65]:52068 "EHLO cesium.clock.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbYKKGdC (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Nov 2008 01:33:02 -0500
Received: from cesium.clock.org (cesium.clock.org [192.5.16.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by cesium.clock.org (Postfix) with ESMTP id 55C7C15F422
	for <linux-sparse@vger.kernel.org>; Mon, 10 Nov 2008 22:24:01 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I'm playing with smatch and noticed that an inline assignment doesn't seem 
to get parsed as such. There's a couple of examples, but this one in 
sparse's own parse.c (line 1480) is probably the best:
   struct ident *ident = NULL;


sparse doesn't seem to identify this as an assignment, only a declaration. 
as a result, smatch gives this false positive:
parse.c +1487 undefined param add_expression 1


Sorry if I'm incorrectly diagnosing the problem; I'm just diving into the 
code for the first time this evening :)

Thanks in advance for any help!

--
tangled strands of DNA explain the way that I behave.
http://www.clock.org/~matt
