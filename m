From: =?UTF-8?B?SmFjZWsgxZpsaXdlcnNraQ==?= <sliwers@googlemail.com>
Subject: Re: Defect in linearization of short circuit &&
Date: Sun, 14 Feb 2010 22:04:29 +0100
Message-ID: <4B78655D.2080007@googlemail.com>
References: <4B77FD0F.50401@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:56254 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0BNVEf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Feb 2010 16:04:35 -0500
Received: by ewy28 with SMTP id 28so3756759ewy.28
        for <linux-sparse@vger.kernel.org>; Sun, 14 Feb 2010 13:04:34 -0800 (PST)
In-Reply-To: <4B77FD0F.50401@googlemail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Apparently, the issue is not with the linearization.  I noticed that the 
condition has been parsed as:

EXPR_BINOP
  * EXPR_LOGICAL
     * EXPR_LOGICAL
        * EXPR_PREOP
        * EXPR_PREOP
     * EXPR_COMPARE
  * EXPR_COMPARE

After replacing EXPR_BINOP with EXPR_LOGICAL in the top node of the 
tree, the linearization works just fine.  Could someone explain me the 
difference between EXPR_BINOP and EXPR_LOGICAL in this context?

Thanks!
Jacek
