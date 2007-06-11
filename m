From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Messing typedefs?
Date: Mon, 11 Jun 2007 13:59:34 +0200
Message-ID: <OF97379DC1.5009215C-ONC12572F7.0034F56B-C12572F7.0041E12D@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.automotion.info ([213.33.116.60]:36923 "EHLO
	mail1.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbXFKL7z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Jun 2007 07:59:55 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Following code

        typedef unsigned char  plcbit;
        typedef unsigned char  USINT;

        USINT usVar1;

leads to a symbol "usVar1" with base_type->ident named "plcbit".
Is this behaviour expected?

Best regards,
Thomas Schmid
