From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Antwort: Re: [PATCH 15/16] deal with enum members without excessive PITA
Date: Fri, 14 Dec 2007 13:09:25 +0100
Message-ID: <OF6BBF04CB.C9CFEDC1-ONC12573B1.003FBE96-C12573B1.0042C7E1@br-automation.com>
References: <70318cbf0712131618k6b3ffc98ibbf68156dc67b52e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:37865 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbXLNMJ3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 14 Dec 2007 07:09:29 -0500
In-Reply-To: <70318cbf0712131618k6b3ffc98ibbf68156dc67b52e@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

linux-sparse-owner@vger.kernel.org schrieb am 14.12.2007 01:18:21:

> It seems there is not good way to get the enum members from the parent 
symbol.
How about the idea, looping over the syms within global_scope?

> It should be trivial make a patch to add members to the parent
> symbol->symbol_list though.
Would you possibly?

Best regards
Thomas Schmid
