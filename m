From: bonneta <bonneta@ensimag.fr>
Subject: help for using sparse
Date: Wed, 09 Jun 2010 17:09:54 +0200
Message-ID: <cd2a19702bb05b6f27255cd697b0ea12@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.imag.fr ([129.88.30.17]:51188 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222Ab0FIPeP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Jun 2010 11:34:15 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o59F29PV028710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 9 Jun 2010 17:02:09 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59F9s5b011810
	for <linux-sparse@vger.kernel.org>; Wed, 9 Jun 2010 17:09:54 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o59F9s0C001411
	for <linux-sparse@vger.kernel.org>; Wed, 9 Jun 2010 17:09:54 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello,

I am working on git, and i would like to apply sparse on its source code.

I've downloaded the source of sparse from its git repository, and compiled
it successfully.

I've read the little documentation furnished with the code, but i didn't
manage to apply sparse on the sources of git.

I've basically tried "sparse file.c", but it always returns with an error
like :
"git-compat-util.h:140:11: error: unable to open 'openssl/ssl.h'"
or
"builtin/blame.c:7:10: error: unable to open 'cache.h'"

I don't know how to resolve it...

Axel



