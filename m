From: Dan Sheridan <djs@postman.org.uk>
Subject: [PATCH 0/2] Improved flow graphs
Date: Wed, 16 May 2007 11:11:21 +0100
Message-ID: <1179310281.31308.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from tuschin.blackcatnetworks.co.uk ([193.201.200.34]:50503 "EHLO
	tuschin.blackcatnetworks.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757046AbXEPK6K (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 May 2007 06:58:10 -0400
Received: from adelard.plus.com ([80.229.44.105] helo=[192.168.254.4])
	by tuschin.blackcatnetworks.co.uk with esmtpa (Exim 4.50)
	id 1HoGTb-0007z1-N4
	for linux-sparse@vger.kernel.org; Wed, 16 May 2007 11:11:23 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Dear all,

It doesn't look like this 0/2 made it the first time round...

These two patches are the first of several implementing improved graph
generation for Sparse. Initially, I am dealing with straight-forward
control flow. Forthcoming patches will add program dependency graphs (a
control and data flow representation suitable for program slicing) and
simple pointer alias analysis (for handling indirect calls).

I've tried to keep the C part of the flow graph relatively simple, and
put the hard stuff (like return edges and subgraph processing) in
post-processing scripts. 

Example graph can be seen at
http://www.postman.org.uk/djs52/example.png, generated with

  ./graph validation/context.c | gvpr -f gvpr/return-paths | \
    gvpr -f gvpr/subg-fwd -a good_while3 | dot -Tpng > /tmp/example.png

Comments welcome.

	Dan Sheridan.

-- 
Daniel Sheridan (djs@adelard.com), Consultant
Adelard LLP, College Building, Northampton Square, London  EC1V 0HB, UK
Tel: +44 (0)20 7490 9455, Fax: +44 (0)20 7490 9451, 
Web: http://www.adelard.com
