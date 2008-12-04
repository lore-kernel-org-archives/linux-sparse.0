From: Yoann Padioleau <padator@wanadoo.fr>
Subject: label_statement ambiguity in parse.h
Date: Wed, 03 Dec 2008 22:29:06 -0600
Message-ID: <87r64owokt.fsf@aryx.cs.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from expredir6.cites.uiuc.edu ([128.174.5.97]:53771 "EHLO
	expredir6.cites.uiuc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYLDEbr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Dec 2008 23:31:47 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org



In parse.h 'struct statement' the same fieldname
"label_statement" is used multiple times. Is it intended ? 


struct statement {
	enum statement_type type;
	struct position pos;
	union {
		struct /* declaration */ {
			struct symbol_list *declaration;
		};
		struct /* label_arg */ {
			struct symbol *label;
==> HERE		struct statement *label_statement;
		};
                ...
		struct /* labeled_struct */ {
			struct symbol *label_identifier;
==> HERE		struct statement *label_statement;
		};




I guess from the gcc point of view it does not make a difference
as it will point to the same address because in both 
cases the items before have the same type and so size, but
if one day someone change one type, the user may have
some surprise ?

