From: conchur@web.de
Subject: Aw: Re: REGRESSION: implied: we have to make the false states match
 as well
Date: Sun, 20 Mar 2016 17:02:03 +0100
Message-ID: <trinity-678321ec-c898-43b9-9faa-09299b271c17-1458489723757@3capp-webde-bap12>
References: <trinity-31872b6a-6152-4832-aeb5-7ad863fb4a89-1458485302988@3capp-webde-bap48>,
 <trinity-4268de0c-d64e-4cce-9d0e-203e17956611-1458489150278@3capp-webde-bap12>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:65309 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847AbcCTQCG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 Mar 2016 12:02:06 -0400
In-Reply-To: <trinity-4268de0c-d64e-4cce-9d0e-203e17956611-1458489150278@3capp-webde-bap12>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

> CHECK="smatch -p=kernel --two-passes" cgcc -c -o test.o test.c

cgcc is optional. It is enough to use following command to get the incorrect warning:

    smatch -p=kernel --two-passes test.c
