document.addEventListener("DOMContentLoaded", function () {
    const provinceSelect = document.getElementById("province");
    const districtSelect = document.getElementById("district");
    const wardSelect = document.getElementById("ward");

    // Hàm lấy danh sách tỉnh/thành phố
    function fetchProvinces() {
        fetch("https://provinces.open-api.vn/api/p/")
            .then((response) => response.json())
            .then((provinces) => {
                provinces.forEach((province) => {
                    const option = document.createElement("option");
                    option.value = province.name;  // Sử dụng tên tỉnh làm giá trị
                    option.textContent = province.name; // Hiển thị tên tỉnh
                    provinceSelect.appendChild(option);
                });
            })
            .catch((error) => console.error("Error fetching provinces:", error));
    }

    // Hàm lấy danh sách quận/huyện theo tỉnh
    function fetchDistricts(provinceName) {
        fetch("https://provinces.open-api.vn/api/p/")
            .then((response) => response.json())
            .then((provinces) => {
                const province = provinces.find((p) => p.name === provinceName);
                if (!province) return;

                fetch(`https://provinces.open-api.vn/api/p/${province.code}?depth=2`)
                    .then((response) => response.json())
                    .then((provinceData) => {
                        const districts = provinceData.districts || [];
                        districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện...</option>';
                        wardSelect.innerHTML = '<option value="">Chọn Phường/Xã...</option>';

                        districts.forEach((district) => {
                            const option = document.createElement("option");
                            option.value = district.name;  // Sử dụng tên quận làm giá trị
                            option.textContent = district.name; // Hiển thị tên quận
                            districtSelect.appendChild(option);
                        });
                    });
            })
            .catch((error) => console.error("Error fetching districts:", error));
    }

    // Hàm lấy danh sách phường/xã theo quận
    function fetchWards(districtName) {
        fetch("https://provinces.open-api.vn/api/d/")
            .then((response) => response.json())
            .then((districts) => {
                const district = districts.find((d) => d.name === districtName);
                if (!district) return;

                fetch(`https://provinces.open-api.vn/api/d/${district.code}?depth=2`)
                    .then((response) => response.json())
                    .then((districtData) => {
                        const wards = districtData.wards || [];
                        wardSelect.innerHTML = '<option value="">Chọn Phường/Xã...</option>';
                        wards.forEach((ward) => {
                            const option = document.createElement("option");
                            option.value = ward.name;  // Sử dụng tên phường làm giá trị
                            option.textContent = ward.name; // Hiển thị tên phường
                            wardSelect.appendChild(option);
                        });
                    });
            })
            .catch((error) => console.error("Error fetching wards:", error));
    }

    // Sự kiện thay đổi tỉnh/thành phố
    provinceSelect.addEventListener("change", function () {
        const provinceName = this.value;  // Sử dụng tên tỉnh để lấy quận/huyện
        if (provinceName) {
            fetchDistricts(provinceName);
        } else {
            districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện...</option>';
            wardSelect.innerHTML = '<option value="">Chọn Phường/Xã...</option>';
        }
    });

    // Sự kiện thay đổi quận/huyện
    districtSelect.addEventListener("change", function () {
        const districtName = this.value;  // Sử dụng tên quận để lấy phường/xã
        if (districtName) {
            fetchWards(districtName);
        } else {
            wardSelect.innerHTML = '<option value="">Chọn Phường/Xã...</option>';
        }
    });

    // Gọi API tỉnh/thành phố khi tải trang
    fetchProvinces();
});
