module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = ApplicationSetup.get_organization_name 
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
  def self.yes_no_arr
    [['', nil], [I18n.t('yes'), 1], [I18n.t('no'), 2]]
  end
end
