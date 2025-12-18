Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD823EAA0;
	Thu, 18 Dec 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038164; cv=none; b=ZpaY1mWLbcwUrii9RHkcE9EyyoVH/hAw7c4HHW5fVVwhOXktQ2fUzwhXME5Qb7zuMMeMTZW6efl0TgRc99WA3/A/bNIyECqwcKr1TFGw0z2IwksQxkM48LBtb4VV3Ct3pvyTsle/cs8Yh8kpq1d1ABYekz1iUQGm3Vz3OIrFQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038164; c=relaxed/simple;
	bh=9o3XLsaj/qV4uTjXYr0vfN9vzzwX56MxhJmKcL9cHgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kC6kK/fi6XEzGTHF+PsnW65A6/DU4J8eFIynoUzcnf1eF6QM70K4X2sRDZp1WRgoqRpdU83WMDsnXIxrWzlHy2KrPZMAol5bblU30VgIdF4OJE9F8S43lMpJOYocusUmWUxhJ6q8fdK34JBpmgYNhyf1FhT0U/gAl8V/oYyAN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CW7EUgJ8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CW7EUgJ8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Gtc6IjksPkltjRmDadhRacRRNxbn0ODNm4VxXmOyhbc=; b=CW7EUgJ8RExLvOshxTzh0KcP5u
	DLAvFLvehCXCVHHsov49uY64YhrFkmxpnnppp99o4x1eYj0wwfEa03rxANjCatduJvUI5ocUBCp7E
	yzJG6Xmtlevte7saJLr6pIWnCeWQ9eiwJTBX3Mpwb1Ll0xa9yG1u6iVCBDLDyRNk3RIFuVuILu48p
	GX/bzNGzpfNmZH9EnuiDIPc2zYkcglumoAZkvR7I8kPYzvnDOTqMgfVRcNWN1g2NHvGoBUyHLrz52
	ev2G8zpSVjvmyG3dQUvv3HIlZBlQOgi5KhfMmY3TNQyiBFMF8TGGvgREydEaMZvw56I5Jn7go7YsN
	bwQDgeHg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW7CU-00000007sTD-2Fcx;
	Thu, 18 Dec 2025 06:09:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Chris Li <sparse@chrisli.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-sparse@vger.kernel.org
Subject: [PATCH] sparse: update MAINTAINERS info.
Date: Wed, 17 Dec 2025 22:09:21 -0800
Message-ID: <20251218060921.995516-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chris Li is back as sparse maintainer.

See https://git.kernel.org/pub/scm/devel/sparse/sparse.git/commit/?id=67f0a03cee4637e495151c48a02be642a158cbbb

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Chris Li <sparse@chrisli.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20251217.orig/MAINTAINERS
+++ linux-next-20251217/MAINTAINERS
@@ -24595,7 +24595,7 @@ F:	drivers/tty/vcc.c
 F:	include/linux/sunserialcore.h
 
 SPARSE CHECKER
-M:	"Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
+M:	Chris Li <sparse@chrisli.org>
 L:	linux-sparse@vger.kernel.org
 S:	Maintained
 W:	https://sparse.docs.kernel.org/
